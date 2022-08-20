import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/services/firestore.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../services/models.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String tags = '';

  final TextEditingController _tagsController = TextEditingController();

  bool isVerified = false;

  void update() {
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
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => update());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List arrayOfTags = [];
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserInfo>(context);

    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            titleWidget: const Text(
              "What skills do you have?",
              style: TextStyle(fontSize: 25),
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
            title: "Verification",
            bodyWidget: Column(
              children: <Widget>[
                const Text("You now have to verify your account"),
                TextButton(
                    onPressed: () {
                      AuthService().user!.sendEmailVerification();
                      AuthService().user!.reload();
                    },
                    child: const Text("Send verification email"))
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
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        },
      ),
    );
  }
}
