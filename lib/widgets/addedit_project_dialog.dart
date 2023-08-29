import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_manager/database/Database.dart';
import 'package:project_manager/screens/project.dart';

import '../models/Project.dart';

class AddEditProjectDialog extends AlertDialog {

  final Project project;
  final String action;
  XFile? _selectedImage;

  AddEditProjectDialog({super.key, required this.project, required this.action});


  @override
  Widget build(BuildContext context) {
    ImagePicker _imagePicker = ImagePicker();
    DateTime _deadline = DateTime.now();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();

    _nameController.text = project.name;
    _descriptionController.text = project.description;
    _deadline = project.dateTime;
    return AlertDialog(
      title: Text("Create / Edit a project"),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                 height: 250,
                 decoration: BoxDecoration(
                  color: Colors.grey,
                  image: _selectedImage != null
                      ? DecorationImage(
                    image: FileImage(File(_selectedImage!.path)),
                    fit: BoxFit.cover,
                  )
                      : null,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                  width: 500, child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          XFile? pickedImage = await _imagePicker.pickImage(
                            source: ImageSource.gallery, //
                          );

                          if (pickedImage != null) {
                            Database db = Database();
                            db.uploadImage(pickedImage, project.id, "banner");
                            setState(() {
                              _selectedImage = pickedImage;
                            });
                          }
                        },
                        child: Text("Select a banner image"),
                      ),
                    ],
                  ),),
                Container(constraints: BoxConstraints(minHeight: 100),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              labelText: "Project name"),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(labelText: "Project description"),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Row(
                          children: [
                            Text("Deadline: "),
                            Padding(padding: EdgeInsets.all(10)),
                            ElevatedButton(
                                onPressed: () async {
                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: _deadline,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );

                                  if (selectedDate != null) {
                                    setState(() {
                                      _deadline = selectedDate;
                                    });
                                  }
                                },
                                child: Text(
                                    "${_deadline.day}/${_deadline
                                        .month}/${_deadline.year}")),
                          ],
                        )
                      ],
                    )),
              ],
            );
          }),
      actions: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context); // back button
          },
          icon: Icon(Icons.arrow_back),
        ),
        IconButton(
          onPressed: () {
            project.name = _nameController.text;
            project.description = _descriptionController.text;
            project.dateTime = _deadline;
            project.save();
            Navigator.pop(context);
            if(action == "create"){
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => ProjectPage(
                            project: project,
                          )));
                }
              },
          icon: Icon(Icons.check),
        ),
      ],
    ),
      ],
    );
  }
}