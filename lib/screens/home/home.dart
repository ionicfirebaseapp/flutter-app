import 'package:flutter/material.dart';
import 'package:todo_open/style/style.dart';
import 'package:todo_open/style/style.dart' as prefix0;
import '../../style/style.dart';
import '../../widgets/getTaskDetails.dart';
import '../../widgets/getPriorityTaskDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../widgets/getCompletedTask.dart';
import '../../services/crud.dart';
import '../../animations/fade_in_ui.dart';

class Home extends StatefulWidget {
  static String tag = "home";
  final String added;
  Home({Key key, this.added}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  crudMedthods crudObj = new crudMedthods();
  var tasks;

  @override
  void initState() {
    super.initState();
    crudObj.getData().then((results) {
      if(mounted){
        setState(() {
          tasks = results;
        });
      }
    });

    userInfo();
  }

  var user, fbuser;

  userInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString('user');
      fbuser = prefs.getString('fbuser');
    });
    print("user...................$user $fbuser");
  }

  String dateNow = DateFormat('d MMM yyyy').format(DateTime.now());

  int _currentIndex = 0;
  final List<Widget> _children = [
    TaskInProgress(),
    TaskCompleted(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      body: Container(
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: <Widget>[
            Container(
              alignment: AlignmentDirectional.center,
              height: 30.0,
              child:
              user != null ? Text('"Dear ${user.toString().split('@')[0]}, May you be on Time "', style: smallAddressWhiteSI(),) :
              Text('"Dear $fbuser, May you be on Time "', style: smallAddressWhiteSI(),),
              color: grey.withOpacity(0.66),
            ),
            Container(
              height: 78.0,
              child: BottomNavigationBar(
                onTap: onTabTapped,
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 32.0,
                unselectedFontSize: 24.0,
                backgroundColor: darkGrey,
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: darkGrey,
                    icon: Text("Today", style: smallAddressWhite2SR(),),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Image.asset("lib/assets/icon/today.png", height: 25.0, width: 25.0,),
//                      Text(dateNow, style: subTitleWhiteSR()),
                    ),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: darkGrey,
                    icon: Text("Task Completed", style: smallAddressWhite2SR(),),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Image.asset("lib/assets/icon/completed.png", height: 25.0, width: 25.0, color: Colors.white70,),
//                      Text("2/10", style: subTitleWhiteSR()),
                    ),
                  )
                ],
              ),
            ),
            _children[_currentIndex],
          ],
        ),
      ),
    );
  }
}


class TaskInProgress extends StatefulWidget {
  @override
  _TaskInProgressState createState() => _TaskInProgressState();
}

class _TaskInProgressState extends State<TaskInProgress> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          Divider(
            height: 5.0,
            color: bgGrey,
          ),
          TaskDetails(),
          Padding(
            padding: EdgeInsetsDirectional.only(
                top: 14.0, bottom: 12.0, start: 15.0),
            child: Text(
              "Priorities Today",
              style: primaryTextUnderline(),
            ),
          ),
          PriorityTaskDetails(),
        ],
      ),
    );
  }
}


class TaskCompleted extends StatefulWidget {
  @override
  _TaskCompletedState createState() => _TaskCompletedState();
}

class _TaskCompletedState extends State<TaskCompleted> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          Divider(
            height: 4.0,
            color: bgGrey,
          ),
          CompletedTaskDetails(),
        ],
      ),
    );
  }
}


