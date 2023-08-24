import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/Project.dart';

class AddEditProjectDialog extends AlertDialog {

  final Project project;
  XFile? _selectedImage;

  AddEditProjectDialog({super.key, required this.project});


  @override
  Widget build(BuildContext context) {
    ImagePicker _imagePicker = ImagePicker();
    DateTime _deadline = DateTime.now();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
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
                            setState(() {
                              _selectedImage = pickedImage;
                            });
                          }
                        },
                        child: Text("Sélectionner une image"),
                      ),
                    ],
                  ),),
                Container(constraints: BoxConstraints(minHeight: 100),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              labelText: "Nom du projet"),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(labelText: "Description"),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Row(
                          children: [
                            Text("Date limite:"),
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
            Navigator.pop(context); // Bouton pour revenir en arrière
          },
          icon: Icon(Icons.arrow_back),
        ),
        IconButton(
          onPressed: () {
            // Ajoutez ici le code pour soumettre les données
            // ...
            Navigator.pop(context); // Bouton pour fermer la boîte de dialogue après la soumission
          },
          icon: Icon(Icons.check),
        ),
      ],
    ),
      ],
    );
  }
}