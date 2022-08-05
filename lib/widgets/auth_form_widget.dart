import 'package:flutter/material.dart';

class EmailAuthForm extends StatefulWidget {
  const EmailAuthForm({Key? key, required this.submitFn}) : super(key: key);

  final void Function(
    String email,
    String password,
    String name,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  State<EmailAuthForm> createState() => _EmailAuthFormState();
}

class _EmailAuthFormState extends State<EmailAuthForm> {
  final _fromKey = GlobalKey<FormState>();
  var _isLogedIn = true;
  String _userPassword = '';
  String _userEmail = '';
  String _userName = '';

  void _trySubmit() {
    final bool? isValid = _fromKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid == true) {
      _fromKey.currentState?.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogedIn,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Image.asset('assets/Logo.png'),
                  ),
                  TextFormField(
                    key: const ValueKey("Email"),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return "Please enter a valid email adress";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: "Email"),
                    onSaved: (newValue) {
                      _userEmail = newValue!;
                    },
                  ),
                  if (!_isLogedIn)
                    TextFormField(
                      key: const ValueKey("Name"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a name";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: "Name"),
                      onSaved: (newValue) {
                        _userName = newValue!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey("Password"),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return "Password has to be at least 7 characters long";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                    onSaved: (newValue) {
                      _userPassword = newValue!;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _trySubmit();
                    },
                    child: Text(_isLogedIn ? "Login" : "Sign up"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogedIn = !_isLogedIn;
                      });
                    },
                    child: Text(_isLogedIn
                        ? "Don't have an account?"
                        : "Already have an account?"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
