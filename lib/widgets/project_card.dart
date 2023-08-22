// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:project_manager/models/Project.dart';

class ProjectCard extends StatelessWidget {
  //final Project project;

  //ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: Colors.black26,
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
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "En cours",
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),)
                ]),
          ),),
          Expanded(flex: 12, child: Padding(padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(child: Container(
                  alignment: Alignment.topLeft,
                  child: Text("A short description."),
                )),
                Expanded(flex: 2, child: Container(
                  child: Row(
                    children: [
                      Expanded(child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Row(
                                children: [ Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ), Padding(padding: EdgeInsets.only(left: 5), child: Text("12 Tâches en attentes"))]),
                            Row(
                                children: [ Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.orangeAccent,
                                  ),
                                ), Padding(padding: EdgeInsets.only(left: 5), child: Text("6 Tâches en cours"))]),
                            Row(
                                children: [ Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ), Padding(padding: EdgeInsets.only(left: 5), child: Text("56 Tâches terminé"))]),
                          ],
                        ),
                      )),
                      Expanded(child: Container(
                        color: Colors.black12,
                        child: Column(
                          children: [
                          ],
                        ),
                      ))
                    ],
                  ),
                ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}