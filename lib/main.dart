import 'package:flutter/material.dart';
import 'style/style.dart';
import 'screens/auth/register.dart';
import 'screens/auth/reset_password.dart';
import 'screens/auth/login.dart';
import 'screens/home/landing.dart';
import 'screens/home/home.dart';
import 'screens/task/add_task.dart';
import 'screens/priority_task/priority_task.dart';
import 'screens/task/task_expanded.dart';
import 'screens/task/task_list.dart';
import 'screens/profile/profile.dart';
import 'screens/settings/settings.dart';
import 'screens/settings/contact_us.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
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
    AddTask.tag: (context) => AddTask(),
    PriorityTask.tag: (context) => PriorityTask(),
    TaskExpanded.tag: (context) => TaskExpanded(),
    TaskList.tag: (context) => TaskList(),
    Profile.tag: (context) => Profile(),
    Settings.tag: (context) => Settings(),
    ContactUs.tag: (context) => ContactUs()
  };

  var login;

  userInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login');
    });
    print("user...................$login ");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: primary,
        accentColor: primary,
        cursorColor: border,
      ),
      home: login == true || login != null ? Landing() : Login(),
      routes: routes,
    );
  }
}
