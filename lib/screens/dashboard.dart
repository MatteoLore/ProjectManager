import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_manager/widgets/addedit_project_dialog.dart';
import 'package:project_manager/widgets/project_card.dart';
import 'package:project_manager/widgets/settings_dialog.dart';

import '../models/Project.dart';
import '../models/User.dart';

class DashboardPage extends StatefulWidget {
  final User user;

  const DashboardPage({super.key, required this.user});

  @override
  State<DashboardPage> createState() => DashboardPageState(user: user);

}

class DashboardPageState extends State<DashboardPage> {

  final User user;

  late List<Project> projects;

  DashboardPageState({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
          Project project = await Project.initialize(user.id);
          showDialog(context: context, builder: (BuildContext context) {
            return AddEditProjectDialog(project: project, action: "create",);
          }).then((value){
            setState(() {
              user.ownerProjectsIds.add(project.id);
              user.projectsIds.add(project.id);
              user.save();
            });
          });
        },
        child: const Icon(Icons.add, color: Color(0xFF78D17F),),),
        body: Padding(padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(children: [
                  Expanded(child: Align(
                  alignment: Alignment.topLeft,
                  child: ImageIcon(AssetImage("assets/images/logo.png"), size: 140,)
                )),
                const Expanded(child: SearchBar(), flex: 2),
                Expanded(child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(context: context, builder: (BuildContext context) {
                            return SettingsDialog(user: user);
                          }).then((value){
                            setState(() {
                            });
                          });
                        },
                        child: CircleAvatar(
                          foregroundImage: Image.asset("assets/images/image.png").image,
                          backgroundColor: Colors.grey,
                          radius: 30,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(user.username)
                    ],
                  ),
                )),
              ],
              ),
              const Padding(padding: EdgeInsets.only(top: 60, bottom: 60)),
              Row(children: [
                const Padding(padding: EdgeInsets.only(right: 20),child: Text("Projects", style: TextStyle(fontSize: 24),)),
                Expanded(flex: 2,child: Container(height: 5, decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],),),)
              ],),
              Expanded(child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(60),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 600,
                        mainAxisSpacing: 40,
                        crossAxisSpacing: 40,
                        childAspectRatio: 1.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return ProjectCard(projectId: user.projectsIds[index], dashboard: this);
                        },
                        childCount: user.projectsIds.length,
                      ),
                    ),
                  ),
                ],
              ))

              //ProjectCard()
            ],
          ),)
    );
  }

}