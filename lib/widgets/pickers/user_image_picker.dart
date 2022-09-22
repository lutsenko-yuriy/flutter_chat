import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final _imagePicker = ImagePicker();

  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage?.path == null) {
      return;
    }

    setState(() {
      _pickedImage = File(pickedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage == null ? null : FileImage(_pickedImage!),
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.image),
            label: const Text('Add I mage')),
      ],
    );
  }
}
