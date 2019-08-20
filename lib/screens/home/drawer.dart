import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/home/landing.dart';
import '../../screens/priority_task/priority_task.dart';
import '../../screens/task/task_list.dart';
import '../../screens/profile/profile.dart';
import '../../screens/settings/settings.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Container(
          alignment: FractionalOffset.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/bg/sidebar_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsetsDirectional.only(top: 180.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Profile",
                  style: productTitle(),
                ),
                leading: Icon(
                  Icons.person,
                  color: Colors.black45,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black45,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Profile.tag);
                },
              ),
              ListTile(
                title: Text(
                  "Home",
                  style: productTitle(),
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.black45,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black45,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Landing.tag);
                },
              ),
              ListTile(
                title: Text(
                  "My Tasks List",
                  style: productTitle(),
                ),
                leading: Icon(
                  Icons.list,
                  color: Colors.black45,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black45,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(TaskList.tag);
                },
              ),
              ListTile(
                title: Text(
                  "Priority Task",
                  style: productTitle(),
                ),
                leading: Icon(
                  Icons.star,
                  color: Colors.black45,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black45,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(PriorityTask.tag);
                },
              ),
              ListTile(
                title: Text(
                  "Settings",
                  style: productTitle(),
                ),
                leading: Icon(
                  Icons.settings,
                  color: Colors.black45,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black45,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Settings.tag);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
