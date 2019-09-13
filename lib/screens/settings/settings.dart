import 'package:flutter/material.dart';
import 'package:todo_open/screens/auth/reset_password.dart';
import 'package:todo_open/style/style.dart' as prefix0;
import '../../style/style.dart';
import '../../screens/home/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../screens/profile/profile.dart';
import '../../screens/settings/contact_us.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  static String tag = "settings";
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _value = false;
  onChanged(bool value) {
    setState(
      () {
        _value = value;
      },
    );
  }

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
    print("user...................$user");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgGrey,
        drawer: DrawerList(),
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Settings", style: subBoldTitleWhite(),),
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
            Container(
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
                      IconButton(icon: Image.asset("lib/assets/icon/notification.png", height: 22.0, width: 22.0, color: Colors.black,)),
                      Text("Push Notifications", style: textSmallStyleGreySS(),),
                    ],
                  ),
                  Container(
                    width: screenWidth(context)*0.3,
                    child: SwitchListTile(
                      value: _value,
                      onChanged: (bool value) {
                        onChanged(value);
                      },
                      activeColor: primary,
                    ),
                  ),
                ],
              )
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(ResetPassword.tag);
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
                        Text("Reset Password", style: textSmallStyleGreySS(),),
                      ],
                    ),
                    IconButton(icon: Image.asset("lib/assets/icon/arrow.png", height: 22.0, width: 22.0,)),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
