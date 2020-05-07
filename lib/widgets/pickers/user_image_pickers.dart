import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
class ImagePickeruser extends StatefulWidget {
  ImagePickeruser(this.imagePickFn);
  final void Function(File pickImage) imagePickFn;
  @override
  _ImagePickeruserState createState() => _ImagePickeruserState();
}

class _ImagePickeruserState extends State<ImagePickeruser> {
  File _pickImage;
  void _pickUrImage() async {
    final pickImageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickImage = pickImageFile;
    });
    widget.imagePickFn(pickImageFile);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 45,
          backgroundImage: _pickImage != null ? FileImage(_pickImage) : null,
        ),
        FlatButton.icon(
          textColor: _pickImage != null ? Colors.blueGrey : Theme.of(context).primaryColor,
          icon: Icon(Icons.image),
          label: Text('Pick Image'),
          onPressed: _pickUrImage,
        ),
      ],
    );
  }
}