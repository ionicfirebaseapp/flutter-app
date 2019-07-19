import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/home/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../screens/profile/profile.dart';
import '../../screens/settings/contact_us.dart';


class Settings extends StatefulWidget {
  static String tag = "settings";
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool _value = false;
  onChanged(bool value) {
    setState(() {
      _value = value;
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(),
      appBar: AppBar(
        title: Text(""),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: bgGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("ACCOUNT", style: productTitle(),),
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
                padding: EdgeInsets.only(left:20.0),
                height: 130.0,
//                width: 380.0,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image(
                          width: 90.0,
                          height: 90.0,
                          image: AssetImage("lib/assets/icon/logo.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0, left: 20.0),
                          child: Text("John Snow", style: categoryTitle(),),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey, height: 3.0,),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(Profile.tag);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top:8.0, bottom: 8.0, right: 8.0, ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("Edit Profile", style: redBoldText(),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text("PUSH NOTIFICATIONS", style: productTitle(),),
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
                height: 80.0,
                color: Colors.white,
                child: Center(
                  child: SwitchListTile(
                    title: Text("John Snow", style: categoryTitle(),),
                    value: _value,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                    activeColor: primary,
                  ),
                ),
              ),
              Text("GET HELP", style: productTitle(),),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ContactUs.tag);
                },
                child: Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
                padding: EdgeInsets.all(20.0),
                height: 80.0,
                color: Colors.white,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Contact Us", style: categoryTitle(),),
                      Icon(FontAwesomeIcons.chevronRight, size: 20.0, color: Colors.grey.shade700,),
                    ],
                  ),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
