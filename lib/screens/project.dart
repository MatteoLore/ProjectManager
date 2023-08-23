import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_manager/widgets/task_card.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => ProjectPageState();
}

class ProjectPageState extends State<ProjectPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add, color: Color(0xFF78D17F)),),
      body: Column(
        children: [
          Expanded(child: Container(
            decoration: BoxDecoration(color: Colors.grey),
          child: Column(
            children: [
              Expanded(child: Stack(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: IconButton(icon: Icon(Icons.arrow_back, size: 40), onPressed: () {  },),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(icon: Icon(Icons.supervised_user_circle_outlined, size: 40,), onPressed: () {  }, ),
                        IconButton(icon: Icon(Icons.delete, size: 40,), onPressed: () {  },),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                    padding: const EdgeInsets.all(20.0),
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
              ],))
            ],
          ),)), // Header, banner, name, status
          Expanded(flex: 2, child: Padding(padding: EdgeInsets.all(20), child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text("A short descripton",)),
                Row(children: [
                  Padding(padding: EdgeInsets.only(right: 20),child: Text("Tasks", style: TextStyle(fontSize: 24),)),
                  Expanded(child: Container(height: 5, decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],),), flex: 2,)
                ],),
                Expanded(flex: 5, child:  CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.all(60),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          mainAxisSpacing: 40,
                          crossAxisSpacing: 40,
                          childAspectRatio: 0.75,
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return TaskCard();
                          },
                          childCount: 10,
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ))), // description, tasks
        ],
      ),
    );
  }

}