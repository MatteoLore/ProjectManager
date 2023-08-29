import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:project_manager/models/User.dart';
import 'package:project_manager/screens/dashboard.dart';
import 'package:project_manager/utils/utils.dart';

import 'database/Database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'Project Manager',
      theme: ThemeData(
        primaryColor: const Color(0xFFE9D8AE),
        scaffoldBackgroundColor: const Color(0xFFDABF7B),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Color(0xFF4D4D4D),fontFamily: "Lato")),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Map<String, String> data = {};

  _MyHomePageState() {
    checkUser();
  }

  checkUser() async {
    await loadData();
    var api = await initFirebase();
    if(api == true){
      Database db = Database();
      User? user = await db.getUserByEmail(data["email"] as String);
      if(user.runtimeType == User){
        return Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => DashboardPage(user: user as User)));
      }else{
        User user = User(id: "id", username: "username", avatarUrl: "avatarUrl", projectsIds: [], ownerProjectsIds: []);
        await db.addUser(user, data["email"] as String);
        return Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => DashboardPage(user: user as User)));
      }
    }
    return false;
  }

  initFirebase() async {
    if(data.isNotEmpty){
      FirebaseAuth.initialize(data["apiKey"] as String, VolatileStore());
      Firestore.initialize(data['projectId'] as String);
      var auth = FirebaseAuth.instance;
      await auth.signIn(data["email"] as String, data["password"] as String);
      if(auth.isSignedIn){
        return true;
      }
      auth.close();
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _apiController = TextEditingController();
    TextEditingController _projectController = TextEditingController();

    return Scaffold(
        body: Padding(padding: const EdgeInsets.all(20),
            child: Center(child: Container(width: 500, child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Project Manager - Welcome !", textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Lato",
                        fontSize: 36,
                        fontWeight: FontWeight.w700)),
                TextField(
                  controller: _apiController,
                  decoration: InputDecoration(labelText: "Api key"),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  controller: _projectController,
                  decoration: InputDecoration(labelText: "ProjectId"),
                ),
                Padding(padding: EdgeInsets.all(30)),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                Padding(padding: EdgeInsets.all(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        String projectId = _projectController.text;
                        String api = _apiController.text;
                        if (Utils.isValidEmail(email)) {
                            Map<String, String> data = {"apiKey": api, "projectId": projectId, "email": email, "password": password};
                            saveData(data);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                            );
                        }
                      },
                      icon: Icon(Icons.check),
                    ),
                  ],
                ),
              ],
            )),))
    );
  }

  Future<void> saveData(Map<String, String> data) async {
    File file = File("user.json");
    String contents = jsonEncode(data);
    await file.writeAsString(contents);
  }


  loadData() async {
    File file = File("user.json");
    if (file.existsSync()) {
      String contents = await file.readAsString();
      data = Map<String, String>.from(jsonDecode(contents));
    }else {
      data = {};
    }
  }

}
