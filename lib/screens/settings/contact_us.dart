import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/home/landing.dart';

class ContactUs extends StatefulWidget {
  static String tag = "contact-us";
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
            "Contact Us",
            style: subTitleWhite(),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: primary,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Landing.tag);
              },
            ),
          ]),
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(
                image: AssetImage("lib/assets/icon/logo.png"),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0)),
              Form(
//                     key: _formKey,
                child: Theme(
                  data: ThemeData(
                    brightness: Brightness.dark,
                    accentColor: primary,
                    inputDecorationTheme: new InputDecorationTheme(
                      labelStyle: new TextStyle(
                        color: primary,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                cursorColor: border,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'User Name',
                                  hintStyle: hintStyleDark(),
                                ),
                                style: hintStyleDark(),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                cursorColor: border,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: hintStyleDark(),
                                ),
                                style: hintStyleDark(),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                cursorColor: border,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Subject',
                                  hintStyle: hintStyleDark(),
                                ),
                                style: hintStyleDark(),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                cursorColor: border,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Message',
                                  hintStyle: hintStyleDark(),
                                ),
                                maxLines: 5,
                                style: hintStyleDark(),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: 15.0, start: 45.0, end: 45.0, bottom: 10.0),
                        child: MaterialButton(
                          height: 45.0,
                          color: secondary,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pushNamed(Landing.tag);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Submit', style: categoryWhite()),
                            ],
                          ),
                          splashColor: secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
