import 'package:flutter/material.dart';
import 'package:project_manager/models/User.dart';

class SettingsDialog extends AlertDialog {

  final User user;

  SettingsDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage("assets/images/image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout),
            ),
            IconButton(
              onPressed: () {
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