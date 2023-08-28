import 'package:flutter/material.dart';
import 'package:project_manager/models/Task.dart';

class AddEditTaskDialog extends AlertDialog {

  final Task task;

  List<Row> status = [
    Row(mainAxisAlignment: MainAxisAlignment.center,children: [ Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),), Padding(padding: EdgeInsets.only(left: 5), child: Text("In waiting", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),))]),
    Row(mainAxisAlignment: MainAxisAlignment.center,children: [ Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.orangeAccent,),), Padding(padding: EdgeInsets.only(left: 5), child: Text("In progress", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),))]),
    Row(mainAxisAlignment: MainAxisAlignment.center,children: [ Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green,),), Padding(padding: EdgeInsets.only(left: 5), child: Text("Completed", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),))]),];

  AddEditTaskDialog({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    Row _statusValue = status[task.status];
    TextEditingController _nameController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();

    _nameController.text = task.name;
    _descriptionController.text = task.description;
    return AlertDialog(
      title: Text("Create / Edit a task"),
      content: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            Padding(padding: EdgeInsets.all(10)),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            Padding(padding: EdgeInsets.all(10)),
            DropdownButton<Row>(
              value: _statusValue,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                color: Colors.transparent,
              ),
              onChanged: (Row? value) {
                setState(() {
                  _statusValue = value!;
                });
              },
              items: status.map<DropdownMenuItem<Row>>((Row value) {
                return DropdownMenuItem<Row>(
                  value: value,
                  child: value,
                );
              }).toList(),
            )
          ],
        );
      },

      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            IconButton(
              onPressed: () {
                task.name = _nameController.text;
                task.description = _descriptionController.text;
                task.status = status.indexOf(_statusValue);



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