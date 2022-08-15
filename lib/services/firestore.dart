import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/services/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

// **************************************************************************
// POSTS RELATED FUNCTIONS
// **************************************************************************

  Stream<List<Post>> streamPosts() {
    return _db.collection('posts').snapshots().map((snapShot) => snapShot.docs
        .map((document) => Post.fromJson(document.data()))
        .toList());
  }

  Future<void> createPost(String text, List skills) async {
    var user = AuthService().user!;
    var ref = _db.collection('posts');

    var newData = {
      'date': DateFormat.yMMMMd('en_US').format(DateTime.now()),
      'likes': 0,
      'skills': skills,
      'text': text,
      'uid': user.uid,
      'userName': user.displayName,
      'userPhoto': user.photoURL,
      "postId": "",
    };

    var result = await ref.add(newData);

    await _db.collection("posts").doc(result.id).update({"postId": result.id});
  }

  Future<List<Post>> findRelatedPosts(skill) async {
    var ref = _db.collection('posts');
    var snapshot = await ref.where("skills", arrayContains: skill).get();
    var data = snapshot.docs.map((s) => s.data());
    var posts = data.map((d) => Post.fromJson(d));
    return posts.toList();
  }

  void deletePost(Post post) async {
    var user = AuthService().user!;
    List docId = [];
    await _db
        .collection('posts')
        .where("text", isEqualTo: post.text)
        .where("uid", isEqualTo: user.uid)
        .where("skills", isEqualTo: post.skills)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        docId.add(doc.id);
      }
    });

    var delete = _db.collection('posts').doc(docId[0]);

    try {
      await delete.delete();
    } catch (e) {
      // return e;
    }
  }

  Future<void> updateLikeCounter(
    String postId,
    bool isLike,
    int currentLikes,
  ) async {
    var user = AuthService().user!;
    int likeVal;
    if (isLike) {
      likeVal = 1;
      var doc = _db.collection("users").doc(user.uid);
      await doc.update({
        "likedPosts": FieldValue.arrayUnion([postId])
      });
    } else {
      likeVal = -1;
      var doc = _db.collection("users").doc(user.uid);
      await doc.update({
        "likedPosts": FieldValue.arrayRemove([postId])
      });
    }
    var likeFinal = currentLikes + likeVal;
    await _db.collection("posts").doc(postId).update({"likes": likeFinal});
  }

// **************************************************************************
// POSTS RELATED FUNCTIONS (END)
// **************************************************************************

// **************************************************************************
// USER RELATED FUNCTIONS
// **************************************************************************

  Future<List<UserInfo>> getUsersData(List uids) async {
    var ref = _db.collection('users');
    var snapshot = await ref.where(FieldPath.documentId, whereIn: uids).get();
    var data = snapshot.docs.map((s) => s.data());
    var users = data.map((d) => UserInfo.fromJson(d));
    return users.toList();
  }

  Future<UserInfo> getUserData(String uid) async {
    var ref = _db.collection('users').doc(uid);
    var snapshot = await ref.get();
    var data = snapshot.data();
    var user = UserInfo.fromJson(data!);
    return user;
  }

  Future<void> updateNotificationCounter(String uid, bool increment) async {
    var doc = _db.collection("users").doc(uid);
    if (increment) {
      await doc.update({"notifications": FieldValue.increment(1)});
    } else {
      await doc.update({"notifications": 0});
    }
  }

  Future<void> createUserData(String uid) {
    var user = AuthService().user!;
    var ref = _db.collection('users').doc(user.uid);

    var data = {
      'uid': user.uid,
      'userPhoto': user.photoURL,
      'userName': user.displayName,
      'isVerified': user.emailVerified,
      'bio': "You might want to change this",
      'likedPosts': [],
      'notifications': 0
    };

    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> createUserDataForEmail(String uid, String name) {
    var user = AuthService().user!;
    var ref = _db.collection('users').doc(user.uid);

    var data = {
      'uid': user.uid,
      'userPhoto':
          "https://imgs.search.brave.com/KbRNVWFimWUnThr3tB08-RFa0i7K1uc-zlK6KQedwUU/rs:fit:860:752:1/g:ce/aHR0cHM6Ly93d3cu/a2luZHBuZy5jb20v/cGljYy9tLzI0LTI0/ODI1M191c2VyLXBy/b2ZpbGUtZGVmYXVs/dC1pbWFnZS1wbmct/Y2xpcGFydC1wbmct/ZG93bmxvYWQucG5n",
      'userName': name,
      'isVerified': user.emailVerified,
      'bio': "You might want to change this",
      'likedPosts': [],
      'notifications': 0
    };

    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> updateSkills(List skills) async {
    var user = AuthService().user!;
    var ref = _db.collection('users').doc(user.uid);

    var data = {
      "skills": skills,
    };

    return ref.set(data, SetOptions(merge: true));
  }

  Stream<UserInfo> streamCurrentUserData() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('users').doc(user.uid);
        return ref.snapshots().map((doc) => UserInfo.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([UserInfo()]);
      }
    });
  }

// **************************************************************************
// USER RELATED FUNCTIONS (END)
// **************************************************************************

// **************************************************************************
// CHAT RELATED FUNCTIONS
// **************************************************************************

  Stream<List<ChatRoom>> streamChatRooms(String uid) {
    var ref = _db.collection("rooms");
    return ref
        .where("participants", arrayContains: uid)
        .orderBy("sentAt", descending: true)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => ChatRoom.fromJson(document.data()))
            .toList());
  }

  Future<Map> getChatRooms(uid) async {
    Map<String, dynamic> room = {};
    List arrayOfIds = [];
    var ref = _db.collection('rooms');
    await ref.where("participants", arrayContains: uid).get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          room["roomId"] = doc.id;
          arrayOfIds.add(doc["participants"]);
        }
        room["ids"] = arrayOfIds[0];
        arrayOfIds = [];
      },
    );
    return room;
  }

  Future<void> createChatRoom(String uid_1, String uid_2) async {
    List participants = [uid_1, uid_2];
    var room = _db.collection("rooms");
    var data = {"participants": participants};
    var newRoom = await room.add(data);
    var messages =
        _db.collection("rooms").doc(newRoom.id).collection("messages");
    final newMessage = {
      'uid': "",
      'text': "",
      'sentAt': Timestamp.now(),
    };
    await messages.add(newMessage);
  }

  Future<void> uploadMessage(String roomId, String message) async {
    var user = AuthService().user!;
    final ref = _db.collection("rooms/$roomId/messages");
    final doc = _db.collection("rooms").doc(roomId);
    final newMessage = {
      'uid': user.uid,
      'text': message,
      'sentAt': Timestamp.now(),
    };

    await ref.add(newMessage);
    await doc.set(
        {"text": message, "sentAt": Timestamp.now()}, SetOptions(merge: true));
  }

  Stream<List<Message>> streamMessages(String roomId) {
    return _db
        .collection('rooms')
        .doc(roomId)
        .collection("messages")
        .orderBy("sentAt", descending: true)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => Message.fromJson(document.data()))
            .toList());
  }

// **************************************************************************
// CHAT RELATED FUNCTIONS (END)
// **************************************************************************

// **************************************************************************
// BLOG RELATED FUNCTIONS
// **************************************************************************

  Stream<List<Blog>> streamBlogData() {
    return _db.collection('blogs').snapshots().map((snapShot) => snapShot.docs
        .map((document) => Blog.fromJson(document.data()))
        .toList());
  }
  // **************************************************************************
  // BLOG RELATED FUNCTIONS (END)
  // **************************************************************************

  void getPermisions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
