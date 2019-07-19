import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/home/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../screens/auth/reset_password.dart';
import '../../screens/categories/category_expanded.dart';

class Profile extends StatefulWidget {
  static String tag = "profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(),
      appBar: AppBar(
        elevation: 0.0,
        title: Text(""),
        iconTheme: IconThemeData(color: Colors.white),
      ),
//      backgroundColor: primary,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("lib/assets/bg/image.png"),
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
                    padding: EdgeInsets.only(left:20.0),
                    height: 130.0,
                    color: primary,
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
                              padding: EdgeInsets.only(top: 33.0, left: 20.0),
                              child: Text("John Snow", style: titleBoldWhite(),),
                            ),
                          ],
                        ),
                        Divider(color: Colors.white, height: 3.0,),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(ResetPassword.tag);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 6.0, bottom: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text("Change Password", style: categoryWhite(),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text("YOUR TASKS", style: categoryWhite(),),
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 30.0,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                         Flexible(
                          flex: 6,
                          child: Container(
                              padding: EdgeInsets.all(20.0),
                              height: 120.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  FloatingActionButton(
                                      elevation: 0.0,
                                      child: Icon(FontAwesomeIcons.briefcase, size: 22.0, color: Colors.deepPurple),
                                      backgroundColor: Colors.grey.shade100,
                                      heroTag: null,
                                      onPressed:() {
                                      Navigator.of(context).pushNamed(CategoryExpanded.tag);
                                    },
                                  ),
                                  Text("Work", style: categoryTitle2(),)
                                ],
                              )
                          ),
                        ),
                        Flexible(
                          flex: 6,
                          child: Container(
                              padding: EdgeInsets.all(20.0),
                              height: 120.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  FloatingActionButton(
                                      elevation: 0.0,
                                      child: Icon(FontAwesomeIcons.handshake, size: 22.0, color: Colors.blue),
                                      backgroundColor: Colors.grey.shade100,
                                      heroTag: null,
                                      onPressed:() {
                                      Navigator.of(context).pushNamed(CategoryExpanded.tag);
                                    },
                                  ),
                                  Text("Meeting", style: categoryTitle2(),)
                                ],
                              )
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  Text("TASKS COMPLETED", style: categoryWhite(),),
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
                    padding: EdgeInsets.all(20.0),
                    height: 140.0,
                    width: 380.0,
                    color: Colors.white,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Image(
                              width: 150.0,
                              height: 150.0,
                              image: AssetImage('lib/assets/icon/graph.png'),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("70% Completed", style: categoryTitle(),),
                                Text("30% Pending", style: categoryTitle(),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
