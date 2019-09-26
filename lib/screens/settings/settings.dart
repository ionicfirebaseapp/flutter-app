import 'package:flutter/material.dart';
import 'package:todo_open/screens/auth/reset_password.dart';
import 'package:todo_open/style/style.dart' as prefix0;
import '../../style/style.dart';
import '../../screens/home/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../screens/profile/profile.dart';
import '../../screens/settings/contact_us.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      print('fb user $fbUser $fbProfile, $fbEmail, $fbId');
    }else if(loginType == 'tw'){
      setState(() {
        twUser = prefs.getString('twUser');
        twId = prefs.getString('twId');
      });
      print('twuser $twUser $twId');
    }else if(loginType == 'fs') {
      FirebaseUser userProfile = await FirebaseAuth.instance.currentUser();

      if (userProfile != null) {
        setState(() {
          userName = userProfile.displayName;
          email = userProfile.email;
          uid = userProfile.uid;
          photoUrl = userProfile.photoUrl;
        });
      }
      print('photourl.................... $userName $photoUrl');
    }
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
                    child: photoUrl != null ? ClipOval(child: Image.network(photoUrl, width: 100, height: 100, fit: BoxFit.cover,)):
                    loginType == 'fb' ?
                    ClipOval(child: Image.network(fbProfile, width: 100, height: 100, fit: BoxFit.cover,)) :
                    Image.asset("lib/assets/icon/user.png", color: Colors.white,),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          loginType == 'fs' ? Text('$userName', style: textStyleOrangeSS(),) :
                          loginType == 'fb' ? Text('$fbUser', style: textStyleOrangeSS(),) :
                          Text('$twUser', style: textStyleOrangeSS(),),
                          loginType == 'fs' ? Text('$email', style: smallBoldDescription(),) :
//                          loginType == 'fb' && fbEmail != null ? Text('$fbEmail', style: smallBoldDescription(),) :
                          Text('', style: smallBoldDescription(),),
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
