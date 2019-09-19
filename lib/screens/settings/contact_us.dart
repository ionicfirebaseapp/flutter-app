import 'package:flutter/material.dart';
import 'package:todo_open/style/style.dart' as prefix0;
import '../../style/style.dart';
import '../../screens/home/landing.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/crud.dart';

class ContactUs extends StatefulWidget {
  static String tag = "contact-us";
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email, subject, message, name;
  bool loading = false;
  crudMedthods crudObj = new crudMedthods();

  sendData() async {
    final FormState form = _formKey.currentState;
    setState(() {
      loading = true;
    });
    if (!form.validate()) {
      return;
    } else {
      form.save();
      crudObj.contactUs({
        'taskTitle': this.name,
        'taskDetail': this.email,
        'priorityTask': subject,
        'notify': message,
      });
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text('Message sent successfully...!!!'),
            duration: Duration(seconds: 1),
          ));

      new Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Landing(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(
            "Contact Us",
            style: subBoldTitleWhite(),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: <Widget>[
            new Image(
              image: new AssetImage("lib/assets/bg/image.png"),
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
                    child: Image(
                      image: AssetImage("lib/assets/icon/logo.png"),
                    ),
                  ),
                  Container(
                    width: prefix0.screenWidth(context)*0.8,
                    padding: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 30.0),
                    child: Text(
                      "If you're facing any kind of problem, reach out us at",
                      style: subTitleWhite2SR(),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Form(
                     key: _formKey,
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
                            padding:
                            EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 15.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: screenWidth(context)*0.83,
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 65.0),
                                  child: TextFormField(
                                    cursorColor: border,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'User Name',
                                      hintStyle: hintStyleDark(),
                                    ),
                                    style: hintStyleDark(),
                                    keyboardType: TextInputType.text,
                                    validator: (String value) {
                                      final RegExp nameExp =
                                      new RegExp(r'^[A-Za-z ]+$');
                                      if (value.isEmpty ||
                                          !nameExp.hasMatch(value)) {
                                        return 'Please enter your name';
                                      }
                                    },
                                    onSaved: (String value) {
                                      name = value;
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: -6.0,
                                  right: (screenWidth(context) * 0.83) - 55.0,
                                  child: Stack(
                                    fit: StackFit.loose,
                                    alignment: AlignmentDirectional.center,
                                    children: <Widget>[
                                      Image.asset("lib/assets/icon/send.png"),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 8.0, left: 2.0),
                                        child: Icon(
                                          FontAwesomeIcons.user,
                                          color: Colors.white,
                                          size: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding:
                            EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 15.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: screenWidth(context)*0.83,
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 65.0),
                                  child: TextFormField(
                                    cursorColor: border,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      hintStyle: hintStyleDark(),
                                    ),
                                    style: hintStyleDark(),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (String value) {
                                      if (value.isEmpty ||
                                          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                              .hasMatch(value)) {
                                        return 'Please enter a valid email';
                                      }
                                    },
                                    onSaved: (String value) {
                                      email = value;
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: -6.0,
                                  right: (screenWidth(context) * 0.83) - 55.0,
                                  child: Stack(
                                    fit: StackFit.loose,
                                    alignment: AlignmentDirectional.center,
                                    children: <Widget>[
                                      Image.asset("lib/assets/icon/send.png"),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 8.0, left: 2.0),
                                        child: Icon(
                                          Icons.mail,
                                          color: Colors.white,
                                          size: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding:
                            EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 15.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: screenWidth(context)*0.83,
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 65.0),
                                  child: TextFormField(
                                    cursorColor: border,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Subject',
                                      hintStyle: hintStyleDark(),
                                    ),
                                    keyboardType: TextInputType.text,
                                    style: hintStyleDark(),
                                    validator: (String value) {
                                      final RegExp nameExp =
                                      new RegExp(r'^[A-Za-z ]+$');
                                      if (value.isEmpty ||
                                          !nameExp.hasMatch(value)) {
                                        return 'Please enter your name';
                                      }
                                    },
                                    onSaved: (String value) {
                                      subject = value;
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: -6.0,
                                  right: (screenWidth(context) * 0.83) - 55.0,
                                  child: Stack(
                                    fit: StackFit.loose,
                                    alignment: AlignmentDirectional.center,
                                    children: <Widget>[
                                      Image.asset("lib/assets/icon/send.png"),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 8.0, left: 2.0),
                                        child: Icon(
                                          Icons.subject,
                                          color: Colors.white,
                                          size: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: prefix0.screenWidth(context)*0.83,
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
                                    keyboardType: TextInputType.text,
                                    validator: (String value) {
                                      final RegExp nameExp =
                                      new RegExp(r'^[A-Za-z ]+$');
                                      if (value.isEmpty ||
                                          !nameExp.hasMatch(value)) {
                                        return 'Please enter your name';
                                      }
                                    },
                                    onSaved: (String value) {
                                      message = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 30.0,
                                start: 45.0,
                                end: 45.0,
                                bottom: 10.0),
                            child: RawMaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              fillColor: secondary,
                              child: Container(
                                height: 45.0,
                                width: screenWidth(context) * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'SUBMIT',
                                      style: subTitleWhiteSR(),
                                    ),
                                      new Padding(
                                        padding: new EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                      ),
                                      loading
                                          ? new Image.asset(
                                        'lib/assets/gif/load.gif',
                                        width: 19.0,
                                        height: 19.0,
                                      )
                                          : new Text(''),
                                  ],
                                ),
                              ),
                              onPressed: sendData,
                              splashColor: secondary,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


