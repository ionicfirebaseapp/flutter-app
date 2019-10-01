import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/auth/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/firestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Register extends StatefulWidget {
  static String tag = 'register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

  String email, password, confirmPassword, name, phone;
  bool loading = false;
  var errorText;

  Firestore store;
  @override
  void initState() {
    super.initState();
    callFireStore();
  }

  callFireStore() async {
    store = await fireStoreCommonService();
  }

  CollectionReference get users => store.collection('users');

  registration() async {
    final FormState form = _formKey.currentState;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });
    if (!form.validate()) {
      return;
    } else {
      form.save();
      print('email name $email $name $password');
//      await LoginService.registerUser(email, password, name).then((onValue) {
      FirebaseUser user = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userNew) {
        print('onvalue $userNew');
        setState(() {
          loading = false;
        });


        userNew.sendEmailVerification().then((_) {

          FirebaseAuth.instance.currentUser().then((val) {
            UserUpdateInfo updateUser = UserUpdateInfo();
            updateUser.displayName = name;
            val.updateProfile(updateUser);
          });


          showDialog<Null>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Container(
                width: 270.0,
                child: new AlertDialog(
                  title: new Text('Thank you for Signing Up with us...!!'),
                  content: new SingleChildScrollView(
                    child: new ListBody(
                      children: <Widget>[
                        new Text('Email verfication link has been sent to your Email Id. Verify it before proceeding with login'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('ok'),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Login(),
                            ),
                                (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                ),
              );
            },
          );

        });
      }).catchError((onError) {
        setState(() {
          loading = false;
        });
        print('onnnnnn $onError');
        errorText = onError.toString().split(',')[1];
        showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Container(
              width: 270.0,
              child: new AlertDialog(
                title: new Text('Please check!!'),
                content: new SingleChildScrollView(
                  child: new ListBody(
                    children: <Widget>[
                      new Text('$errorText'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('ok'),
                    onPressed: () {Navigator.pop(context);},
                  ),
                ],
              ),
            );
          },
        );
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image(
              image: new AssetImage("lib/assets/bg/image.png"),
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 40.0,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
                      child: Image(
                        image: AssetImage("lib/assets/icon/logo.png"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 30.0),
                      child: Text(
                        "Register If you don't have an account",
                        style: subTitleWhite2SR(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Theme(
                        data: ThemeData(
                          brightness: Brightness.dark,
                          accentColor: primary,
                          inputDecorationTheme: InputDecorationTheme(
                            labelStyle: TextStyle(
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
                                        hintText: 'Password',
                                        hintStyle: hintStyleDark(),
                                      ),
                                      keyboardType: TextInputType.text,
                                      style: hintStyleDark(),
                                      validator: (String value) {
                                        if (value.isEmpty || value.length < 6) {
                                          return 'Password invalid';
                                        }
                                      },
                                      controller: _passwordTextController,
                                      onSaved: (String value) {
                                        password = value;
                                      },
                                      obscureText: true,
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
                                            Icons.lock_outline,
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
                              padding:
                              EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
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
                                        hintText: 'Confirm Password',
                                        hintStyle: hintStyleDark(),
                                      ),
                                      keyboardType: TextInputType.text,
                                      style: hintStyleDark(),
                                      obscureText: true,
                                      validator: (String value) {
                                        if (_passwordTextController.text !=
                                            value) {
                                          return 'Passwords do not match.';
                                        }
                                      },
                                      onSaved: (String value) {
                                        confirmPassword = value;
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
                                            Icons.lock_outline,
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
                                        'REGISTER',
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
                                onPressed: registration,
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
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Login.tag);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 14.0),
                  child: Text(
                    "Already have an Account ? Login",
                    style: subTitleWhiteUnderline2(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}