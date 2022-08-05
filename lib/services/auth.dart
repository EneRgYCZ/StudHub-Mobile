import 'package:studhub/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      if (authResult.additionalUserInfo!.isNewUser) {
        FirestoreService().createUserData(authResult.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      //return e;
    }
  }

  Future emailLogin(String email, String password) async {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future emailSignUp(String email, String password, String name) async {
    UserCredential authResult =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirestoreService().createUserDataForEmail(authResult.user!.uid, name);
  }
}
