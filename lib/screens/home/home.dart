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
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  static String tag = "home";
  final String added;
  Home({Key key, this.added}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  crudMedthods crudObj = new crudMedthods();
  var tasks;

  @override
  void initState() {
    super.initState();
    userInfo();
  }

  var userName, email, photoUrl, uid, emailVerified;
  var fbUser, fbEmail, fbProfile, fbId;
  var twUser, twId;
  var loginType;

  userInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginType = prefs.getString('loginType');
    });
    print("logintype ...................$loginType");
     if(loginType == 'fb'){
       setState(() {
         fbUser = prefs.getString('fbUser');
         fbEmail = prefs.getString('fbEmail');
         fbId = prefs.getString('fbId');
         fbProfile = prefs.getString('fbProfile');
       });
       print('fbbuser $fbUser $fbProfile, $fbEmail, $fbId');
     }else if(loginType == 'tw'){
      setState(() {
        twUser = prefs.getString('twUser');
        twId = prefs.getString('twId');
      });
      print('twuser $twUser $twId');
    }else if(loginType == 'fs') {
       final FirebaseUser userProfile = await FirebaseAuth.instance.currentUser();
       if (userProfile != null) {
         userName = userProfile.displayName;
         email = userProfile.email;
//      photoUrl = userProfile.photoURL;
//      emailVerified = userProfile.emailVerified;
         uid = userProfile.uid;
       }
       print('user name ....................$userName $email $uid');
     }

     getData();

  }

  getData() async{
    print("loginType 4444...................$loginType");
    crudObj.getData(loginType == 'fs'? uid : loginType == 'fb' ? fbId : twId).then((results) {
      if(mounted){
        setState(() {
          tasks = results;
        });
      }
    });
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
      key: _scaffoldKey,
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
              loginType == 'fb' ? Text('"Dear $fbUser, May you be on Time "', style: smallAddressWhiteSI(),) :
              loginType == 'fs' ? Text('"Dear $userName, May you be on Time "', style: smallAddressWhiteSI(),) :
              Text('"Dear $twUser, May you be on Time "', style: smallAddressWhiteSI(),),
              color: grey.withOpacity(0.66),
            ),
            Container(
              height: 80.0,
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


