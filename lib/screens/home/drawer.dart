import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/home/landing.dart';
import '../../screens/priority_task/priority_task.dart';
import '../../screens/task/task_list.dart';
import '../../screens/profile/profile.dart';
import '../../screens/settings/settings.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import '../../screens/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/settings/contact_us.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  signOutGoogle() async{
    await googleSignIn.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Login(),
        ),(Route<dynamic> route) => false);

    print("User Sign Out");
  }

  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: '1OR06t702rtEEMGEDhe5Lfxpd',
    consumerSecret: 'vw7jKpy45DlE8Y0wpB5o886olhTgwsfFbLoRTmftWRGQ1qQwnT',
  );

  String _message = 'Logged out.';

  _twitterLogout() async {
    await twitterLogin.logOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Login(),
        ),(Route<dynamic> route) => false);

    setState(() {
      _message = 'Logged out.';
    });
  }

  static final FacebookLogin facebookSignIn = new FacebookLogin();

  _facebookLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('fbLogin', false);
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Login(),
      ),(Route<dynamic> route) => false);
  }

  void _showMessage(String message) {
    setState(() {
      message = message;
    });
  }

  bool selected = false;



  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
      ),
      child: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(12.0),
              alignment: AlignmentDirectional.topEnd,
              child: Image.asset("lib/assets/icon/drawerIcon.png"),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        selected = true;
                      });
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(Profile.tag);
                    },
                    child: ListTile(
                      leading: Icon(Icons.person_outline, color: Colors.black,),
                      title: Text("Profile", style: productTitle(),),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(Landing.tag);
                    },
                    child: ListTile(
                      leading: Image.asset("lib/assets/icon/home.png", height: 22.0, width: 22.0,),
                      title: Text("Home", style: productTitle(),),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(Settings.tag);
                    },
                    child: ListTile(
                      leading: Image.asset("lib/assets/icon/settings.png", height: 22.0, width: 22.0,),
                      title: Text("Settings", style: productTitle(),),
                    ),
                  ),
//                  InkWell(
//                    onTap: () {
//                      Navigator.of(context).pop();
//                    },
//                    child: ListTile(
//                      leading: Image.asset("lib/assets/icon/info.png", height: 22.0, width: 22.0,),
//                      title: Text("About us", style: productTitle(),),
//                    ),
//                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(ContactUs.tag);
                    },
                    child: ListTile(
                      leading: Image.asset("lib/assets/icon/help.png", height: 22.0, width: 22.0,),
                      title: Text("Help", style: productTitle(),),
                    ),
                  ),
                  InkWell(
                    onTap: () async{
                      Navigator.of(context).pop();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('fbLogin', false);
                      prefs.setBool('login', false);
                      signOutGoogle() ||
                      _facebookLogOut()
                      || _twitterLogout();
                    },
                    child: ListTile(
                      leading: Image.asset("lib/assets/icon/signout.png", height: 22.0, width: 22.0,),
                      title: Text("Sign out", style: productTitle(),),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}