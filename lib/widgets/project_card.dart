// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:project_manager/models/Project.dart';

class ProjectCard extends StatelessWidget {
  //final Project project;

  //ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: () {  },
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 11, child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blueAccent, Colors.greenAccent]

              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 7, left: 7),
                    child: ClipRRect(borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                        child: LinearProgressIndicator(
                          value: 0.5,
                          minHeight: 5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue),
                          backgroundColor: Colors.transparent,
                        )),),
                  Expanded(child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Project name",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:                             Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [ Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orangeAccent,
                                ),
                              ), Padding(padding: EdgeInsets.only(left: 5), child: Text("En cours", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),))]),
                        ),
                      ),
                    ],
                  ),)
                ]),
          ),), // Banner image, Project name, Status, Progress bar
          Expanded(flex: 12, child: Padding(padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(child: Container(
                  alignment: Alignment.topLeft,
                  child: Text("A short description.", style: TextStyle(fontStyle: FontStyle.normal, color: Color(0xFFB0B0B0)),),
                )),
                Expanded(flex: 2, child: Container(
                  child: Row(
                    children: [
                      Expanded(child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                children: [ Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ), Padding(padding: EdgeInsets.only(left: 5), child: Text("12 Tâches en attentes", style: TextStyle(fontStyle: FontStyle.normal),))]),
                            Row(
                                children: [ Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.orangeAccent,
                                  ),
                                ), Padding(padding: EdgeInsets.only(left: 5), child: Text("6 Tâches en cours", style: TextStyle(fontStyle: FontStyle.normal)))]),
                            Row(
                                children: [ Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ), Padding(padding: EdgeInsets.only(left: 5), child: Text("56 Tâches terminé", style: TextStyle(fontStyle: FontStyle.normal)))]),
                          ],
                        ),
                      )), // Task manager
                      Expanded(child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Date limite: 22/09/12", style: TextStyle(fontStyle: FontStyle.normal)),
                            Expanded(child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Positioned(
                                  width: 30,
                                  height: 30,
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage("assets/images/image.jpg"),
                                    backgroundColor: Colors.lightGreen,
                                    radius: 20,
                                  ),
                                ),
                                Positioned(
                                  width: 30,
                                  height: 30,
                                  right: 20,
                                  bottom: 0,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage("assets/images/image.jpg"),
                                    backgroundColor: Colors.lightGreen,
                                    radius: 20,
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      )) // Limit date, members
                    ],
                  ),
                ))
              ],
            ),
          )) // Description, Task, Limit date, Members
        ],
      )),
    );
  }
}