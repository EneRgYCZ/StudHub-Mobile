import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/services/firestore.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:introduction_screen/introduction_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String tags = '';

  final TextEditingController _tagsController = TextEditingController();

  bool isVerified = false;

  void updateUserState() {
    AuthService().user!.reload();
    if (AuthService().user!.emailVerified) {
      setState(() {
        isVerified = true;
      });
    } else {
      setState(() {
        isVerified = false;
      });
    }
  }

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => updateUserState());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List arrayOfTags = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            titleWidget: const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "What skills do you have?",
                style: TextStyle(fontSize: 25),
              ),
            ),
            bodyWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  arrayOfTags.isEmpty
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Tags(
                                itemCount: arrayOfTags.length,
                                itemBuilder: (int index) {
                                  return Tooltip(
                                    message: arrayOfTags[index],
                                    child: ItemTags(
                                      textActiveColor: Colors.white,
                                      activeColor: Colors.blueGrey,
                                      color: Colors.blueGrey,
                                      textColor: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      index: index,
                                      title: arrayOfTags[index],
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: TextField(
                      controller: _tagsController,
                      decoration:
                          const InputDecoration(labelText: "Add a tag..."),
                      onChanged: (value) {
                        setState(() {
                          tags = value;
                        });
                      },
                      onSubmitted: (value) {
                        arrayOfTags.add(value);
                        setState(() {
                          _tagsController.clear();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          PageViewModel(
            titleWidget: const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "Verification",
                style: TextStyle(fontSize: 25),
              ),
            ),
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text("You now have to verify your account"),
                TextButton(
                    onPressed: () {
                      AuthService().user!.sendEmailVerification();
                      AuthService().user!.reload();
                    },
                    child: const Text("Send verification email")),
                isVerified
                    ? Lottie.network(
                        "https://assets1.lottiefiles.com/packages/lf20_2mm5zqab.json",
                        repeat: false,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
        showBackButton: true,
        back: const Text("Back"),
        done: isVerified ? const Text("Done") : const SizedBox.shrink(),
        next: const Text("Next"),
        onDone: () {
          FirestoreService().updateSkills(arrayOfTags);
          FirestoreService().updatIsVerified(isVerified);
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        },
      ),
    );
  }
}
