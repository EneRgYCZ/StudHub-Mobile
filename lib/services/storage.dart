import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/services/firestore.dart';

class FirebaseStorageService {
  final storage = FirebaseStorage.instance;

  Future<void> uploadImages(File image) async {
    final user = AuthService().user!;
    var userImage =
        storage.ref().child("/profile_images").child(user.uid + '.jpg');
    await userImage.putFile(image);
    final path = await userImage.getDownloadURL();
    await user.updatePhotoURL(path);
    FirestoreService().updateUserPhoto(path);
  }
}
