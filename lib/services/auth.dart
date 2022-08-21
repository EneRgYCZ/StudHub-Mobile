import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:studhub/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserCredential> googleLogin() async {
    final googleUser = await GoogleSignIn().signIn();
    /* if (googleUser == null) {
        return;
      } */
    final googleAuth = await googleUser?.authentication;
    final authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final authResult =
        await FirebaseAuth.instance.signInWithCredential(authCredential);
    if (authResult.additionalUserInfo!.isNewUser) {
      user!.sendEmailVerification();
      user!.reload();
    }
    return authResult;
  }

  Future emailLogin(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
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
    authResult.user!.updateDisplayName(name);
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    final authResult =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    if (authResult.additionalUserInfo!.isNewUser) {
      FirestoreService().createUserData(authResult.user!.uid);
    }
    return authResult;
  }
}
