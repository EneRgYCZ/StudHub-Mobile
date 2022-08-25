import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/services/storage.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? image;

  void _pickImage() async {
    final _picker = ImagePicker();
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      image = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDetails>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image != null
            ? CircleAvatar(
                radius: 40,
                backgroundImage: FileImage(image!),
              )
            : CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.userPhoto),
              ),
        TextButton(
          onPressed: _pickImage,
          child: const Text("Change image"),
        ),
        ElevatedButton.icon(
          onPressed: () {
            FirebaseStorageService().uploadImages(image!);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
          icon: const Icon(Icons.upload),
          label: const Text("Update"),
        )
      ],
    );
  }
}
