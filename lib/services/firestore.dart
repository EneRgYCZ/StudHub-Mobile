import 'dart:async';
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
    };

    try {
      ref.add(newData);
    } catch (e) {
      //return e;
    }
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
    var ref = await _db
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

  Future<void> createUserData(String uid) {
    var user = AuthService().user!;
    var ref = _db.collection('users').doc(user.uid);

    var data = {
      'uid': user.uid,
      'userPhoto': user.photoURL,
      'userName': user.displayName,
      'isVerified': user.emailVerified,
      'bio': "You might want to change this",
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

  Future<void> uploadMessage(String roomId, String message) async {
    var user = AuthService().user!;
    final ref = _db.collection("rooms/$roomId/messages");
    final newMessage = {
      'uid': user.uid,
      'text': message,
      'sentAt': Timestamp.now(),
    };

    await ref.add(newMessage);
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
}

// **************************************************************************
// BLOG RELATED FUNCTIONS (END)
// **************************************************************************