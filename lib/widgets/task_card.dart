import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: () {},
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Padding(padding: EdgeInsets.all(20), child: Column(
        children: [
          Text("Task Name"),
          Padding(child: Container(height: 5, decoration: BoxDecoration(color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],),), padding: EdgeInsets.all(10)),
          Expanded(child: Text("The task description"), flex: 2,),
          Padding(child: Container(height: 5, decoration: BoxDecoration(color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],),), padding: EdgeInsets.all(10)),
          Padding(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [ Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orangeAccent,
                ),
              ), Padding(padding: EdgeInsets.only(left: 5), child: Text("En cours", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),))]), padding: EdgeInsets.all(10),)
        ],
      ))
    ),
    );
  }

}