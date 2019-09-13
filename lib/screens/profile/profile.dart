import 'package:flutter/material.dart';
import 'package:todo_open/screens/priority_task/priority_task.dart';
import 'package:todo_open/screens/settings/contact_us.dart';
import 'package:todo_open/screens/task/task_list.dart';
import 'package:todo_open/style/style.dart' as prefix0;
import '../../style/style.dart';
import '../../screens/home/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  static String tag = "profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    super.initState();
    userInfo();
  }

  var user, fbuser;

  userInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString('user');
      fbuser = prefs.getString('fbuser');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefix0.bgGrey,
      drawer: DrawerList(),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Profile", style: subBoldTitleWhite(),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Container(
            height: 70.0,
            margin: EdgeInsets.only(bottom: 14.0),
            width: screenHeight(context),
            padding: EdgeInsets.all(14.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: primary.withOpacity(0.4),
                  child: Image.asset("lib/assets/icon/user.png", color: Colors.white,),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        user != null ? Text('${user.toString().split('@')[0]}', style: textStyleOrangeSS(),) :
                          Text('$fbuser', style: textStyleOrangeSS(),),
                        user != null ? Text('$user', style: smallBoldDescription(),) :
                          Text('$fbuser', style: smallBoldDescription(),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(PriorityTask.tag);
            },
            child: Container(
              height: 70.0,
              width: screenHeight(context),
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(bottom: 14.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(icon: Image.asset("lib/assets/icon/timeline.png", height: 22.0, width: 22.0,)),
                      Text("Priority Tasks", style: textSmallStyleGreySS(),),
                    ],
                  ),
                  IconButton(icon: Image.asset("lib/assets/icon/arrow.png", height: 22.0, width: 22.0,)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(TaskList.tag);
            },
            child: Container(
              height: 70.0,
              width: screenHeight(context),
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(bottom: 14.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(icon: Image.asset("lib/assets/icon/completed.png", height: 22.0, width: 22.0, color: Colors.black,)),
                      Text("Task List", style: textSmallStyleGreySS(),),
                    ],
                  ),
                  IconButton(icon: Image.asset("lib/assets/icon/arrow.png", height: 22.0, width: 22.0,)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(ContactUs.tag);
            },
            child: Container(
              height: 70.0,
              width: screenHeight(context),
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(bottom: 14.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Image.asset("lib/assets/icon/help.png", height: 22.0, width: 22.0, color: Colors.black,)),
                  Text("Help", style: textSmallStyleGreySS(),),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
