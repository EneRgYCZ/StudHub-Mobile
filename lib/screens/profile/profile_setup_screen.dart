import 'package:flutter/material.dart';
import 'package:studhub/widgets/profile/profile_setup_introduction_widget.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Setup")),
      body: const ProfileSetupIntroductionWidget(),
    );
  }
}
