import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/services/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Post>> getPosts() async {
    var ref = _db.collection('posts');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var posts = data.map((d) => Post.fromJson(d));
    return posts.toList();
  }

  Future<void> createPost(title, text) async {
    var user = AuthService().user!;
    var ref = _db.collection('posts');

    var newData = {
      'date': DateTime.now(),
      'title': title,
      'skills': ["laser", "cacat"],
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

  Stream<UserExtraInfo> streamUserExtraData() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('userExtraData').doc(user.uid);
        return ref
            .snapshots()
            .map((doc) => UserExtraInfo.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([UserExtraInfo()]);
      }
    });
  }

  Future<void> updateUserData(UserExtraInfo userData) {
    var user = AuthService().user!;
    var ref = _db.collection('userExtraData').doc(user.uid);

    var data = {
      'bio': userData.bio,
    };

    return ref.set(data, SetOptions(merge: true));
  }
}
