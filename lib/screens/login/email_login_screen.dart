import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/widgets/auth/auth_form_widget.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({Key? key}) : super(key: key);

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  void _submitAuthForm(
    String email,
    String password,
    String name,
    bool isLogin,
    BuildContext ctx,
  ) async {
    try {
      if (isLogin) {
        AuthService().emailLogin(email, password);
        Navigator.of(ctx).pushNamedAndRemoveUntil('/', (route) => false);
      } else {
        AuthService().emailSignUp(email, password, name);
        Navigator.of(ctx)
            .pushNamedAndRemoveUntil('/profile_setup', (route) => false);
      }
    } on PlatformException catch (e) {
      String? message = "Error occured please check your credentials";

      if (e.message != null) {
        message = e.message;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message!),
          backgroundColor: Colors.red,
        ),
      );
    } on FirebaseAuthException catch (e) {
      String? message = "Error occured please check your credentials";

      if (e.message != null && e.code == "wrong-password") {
        message = "Your email or password are incorrect";
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EmailAuthFormWidget(
        submitFn: _submitAuthForm,
      ),
    );
  }
}
