import 'package:flutter/material.dart';
import 'package:studhub/shared/image_picker_widget.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: ImagePickerWidget()));
  }
}
