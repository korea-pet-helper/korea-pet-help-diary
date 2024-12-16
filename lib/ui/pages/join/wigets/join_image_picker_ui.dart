import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class JoinImagePickerUi {
  Widget imagePickerUi(XFile? selectedImage) {
    return Container(
      height: 100,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        image: selectedImage != null
            ? DecorationImage(
                image: FileImage(
                  File(selectedImage.path),
                ),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: selectedImage == null
          ? Icon(Icons.camera_alt, color: Colors.grey)
          : null,
    );
  }
}
