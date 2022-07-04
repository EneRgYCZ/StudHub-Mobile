import 'dart:async';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/services/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

// **************************************************************************
// Future Non-Void
// **************************************************************************

  Future<List<Post>> getPosts() async {
    var ref = _db.collection('posts');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var posts = data.map((d) => Post.fromJson(d));
    return posts.toList();
  }

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

  Future<List> getChatRooms(uid) async {
    List array = [];
    var ref = _db.collection('rooms');
    var snapshot =
        await ref.where("participants", arrayContains: uid).get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          array.add(doc["participants"]);
        }
      },
    );
    return array[0];
  }

// **************************************************************************
// Future Void
// **************************************************************************

  Future<void> uploadMessage(String reciverUid, String message) async {
    var user = AuthService().user!;
    final ref = _db.collection("rooms/$reciverUid/messages");
    final newMessage = {
      'uid': user.uid,
      'message': message,
      'userPhoto': user.photoURL,
      'userName': user.displayName,
      'createdAt': DateTime.now()
    };

    await ref.add(newMessage);
  }

  Future<void> createPost(text) async {
    var user = AuthService().user!;
    var ref = _db.collection('posts');

    var newData = {
      'date': DateFormat.yMMMMd('en_US').format(DateTime.now()),
      'skills': ["CSS", "JSX"],
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

// **************************************************************************
// Streams
// **************************************************************************

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

  Stream<List<Blog>> streamBlogData() {
    return _db.collection('blogs').snapshots().map((snapShot) => snapShot.docs
        .map((document) => Blog.fromJson(document.data()))
        .toList());
  }

  /*
  Stream<List<Message>> streamMessages(String uid) {
    return _db.collection("users/$uid/messages").get();

  }*/
}
