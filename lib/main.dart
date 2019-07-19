import 'package:flutter/material.dart';
import 'style/style.dart';
import 'screens/auth/register.dart';
import 'screens/auth/reset_password.dart';
import 'screens/auth/login.dart';
import 'screens/home/landing.dart';
import 'screens/home/home.dart';
import 'screens/categories/categories.dart';
import 'screens/categories/category_expanded.dart';
import 'screens/task/add_task.dart';
import 'screens/priority_task/priority_task.dart';
import 'screens/task/task_expanded.dart';
import 'services/firestoreService.dart';
import 'screens/task/task_list.dart';
import 'screens/profile/profile.dart';
import 'screens/settings/settings.dart';
import 'screens/task/recorder.dart';
import 'screens/settings/contact_us.dart';


void main() async {
  fireStoreCommonService();
  runApp(MyApp());
  }


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final routes = <String, WidgetBuilder>{
    Register.tag: (context) => Register(),
    Login.tag: (context) => Login(),
    ResetPassword.tag: (context) => ResetPassword(),
    Landing.tag: (context) => Landing(),
    Home.tag: (context) => Home(),
    Categories.tag: (context) => Categories(),
    CategoryExpanded.tag: (context) => CategoryExpanded(),
    AddTask.tag: (context) => AddTask(),
    PriorityTask.tag: (context) => PriorityTask(),
    TaskExpanded.tag: (context) => TaskExpanded(),
    TaskList.tag: (context) => TaskList(),
    Profile.tag: (context) => Profile(),
    Settings.tag: (context) => Settings(),
    Recorder.tag: (context) => Recorder(), 
    ContactUs.tag: (context) => ContactUs()
  };

  List ser = new List();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: primary,
        accentColor: primary,
      ),
      home: Login(),
      routes: routes,
    );
  }
}
