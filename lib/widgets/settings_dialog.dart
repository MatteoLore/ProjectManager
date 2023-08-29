import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_manager/main.dart';
import 'package:project_manager/models/User.dart';

import '../database/Database.dart';

class SettingsDialog extends AlertDialog {

  final User user;
  XFile? _selectedImage;

  SettingsDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    ImagePicker _imagePicker = ImagePicker();
    TextEditingController _usernameController = TextEditingController();
    _usernameController.text = user.username;
    return AlertDialog(
      title: Text("Settings"),
      content: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                image: _selectedImage != null
                    ? DecorationImage(
                  image: FileImage(File(_selectedImage!.path)),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(

                  onPressed: () async {
                    XFile? pickedImage = await _imagePicker.pickImage(
                      source: ImageSource.gallery, //
                    );

                    if (pickedImage != null) {
                      Database db = Database();
                      db.uploadImage(pickedImage, user.id, "avatar");
                      setState(() {
                        _selectedImage = pickedImage;
                      });
                    }else{
                      setState((){
                        _selectedImage = null;
                      });
                    }
                  },
                  child: Text("Select a avatar image", style: TextStyle(color: Colors.white),),
                ),
              ],
            ),),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
          ],
        );
      },),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () async {
                File file = File("user.json");
                await file.writeAsString("");
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
              },
              icon: Icon(Icons.logout),
            ),
            IconButton(
              onPressed: () {
                user.username = _usernameController.text;
                user.save();
                Navigator.pop(context);
              },
              icon: Icon(Icons.check),
            ),
          ],
        ),
      ],
    );
  }
}