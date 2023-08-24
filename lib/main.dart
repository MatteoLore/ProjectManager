import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_manager/models/Project.dart';
import 'package:project_manager/models/Task.dart';
import 'package:project_manager/models/User.dart';
import 'package:project_manager/screens/dashboard.dart';
import 'package:project_manager/screens/project.dart';
import 'package:project_manager/widgets/addedit_project_dialog.dart';
import 'package:project_manager/widgets/addedit_task_dialog.dart';
import 'package:project_manager/widgets/delete_alert_dialog.dart';
import 'package:project_manager/widgets/settings_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(name: "", options: FirebaseOptions(apiKey: apiKey, appId: appId, messagingSenderId: messagingSenderId, projectId: projectId));
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
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
                Padding(padding: EdgeInsets.all(10)),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.settings),
                    ),
                    IconButton(
                      onPressed: () {
                        // Soumettre les données de connexion ici
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        print("Email: $email, Password: $password");
                      },
                      icon: Icon(Icons.check),
                    ),
                  ],
                ),
              ],
            )),))
    );
  }
}
