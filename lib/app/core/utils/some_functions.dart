import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class SomeFunctions {
  // for picking up image from gallery
  _pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
  }

  Uint8List? file;

  Future<Uint8List?> selectImage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Upload Profile Photo",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take Photo"),
              onPressed: () async {
                Navigator.pop(context);

                file = await _pickImage(ImageSource.camera);
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                file = await _pickImage(ImageSource.gallery);
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );

    return file;
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    return date.toUtc();
  }
}
