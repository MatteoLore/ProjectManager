import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_manager/widgets/project_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => DashboardPageState();

}

class DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {},
        child: const Icon(Icons.add, color: Color(0xFF78D17F),),),
        body: Padding(padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(children: [
                 Expanded(child: Container(child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.dashboard, size: 64,),
                ),)),
                Expanded(child: SearchBar(), flex: 2),
                Expanded(child: Container(child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/image.jpg"),
                      ),
                      Text("Username")
                    ],
                  ),
                ),)),
              ],
              ),
              Padding(padding: EdgeInsets.only(top: 60, bottom: 60)),
              Row(children: [
                Padding(padding: EdgeInsets.only(right: 20),child: Text("Projects", style: TextStyle(fontSize: 24),)),
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
              Expanded(child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.all(60),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 600,
                        mainAxisSpacing: 40,
                        crossAxisSpacing: 40,
                        childAspectRatio: 1.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return ProjectCard();
                        },
                        childCount: 10,
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