import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/auth/register.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../screens/home/landing.dart';
import 'dart:async';

class Login extends StatefulWidget {
  static String tag = "login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _passwordTextController = TextEditingController();

  bool value1 = true;
  String email,password;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void onChangedValue1(bool value) {
    setState(() {
      value1 = value;
    });
  }

   SignInUser(){
     Navigator.of(context).pushNamed(Landing.tag);
    // final FormState form = _formKey.currentState;
    // if (!form.validate()) {
    //   return;
    // } else {
      // form.save();
      // showDialog<Null>(
      //     context: context,
      //     barrierDismissible: false, // user must tap button!
      //     builder: (BuildContext context) {
      //       return new AlertDialog(
      //         title: new Text('wow..'),
      //         content: new SingleChildScrollView(
      //           child: new ListBody(
      //             children: <Widget>[
      //               new Text('You are LoggedIn successfully!!'),
      //             ],
      //           ),
      //         ),
      //         actions: <Widget>[
      //           new FlatButton(
      //             child: new Text('okay'),
      //             onPressed: () {   
      //               Navigator.of(context).pushNamed(Landing.tag);
      //             },
      //           ),
      //         ],
      //       );
      //     },
      //   );
    //   registerUser(email, password).then((response) {
    //     // print('res ${response.uid}');
    //   users.document(response.uid).setData({ email: email,name: name})
    //   .then((res) {
    //        Navigator.of(context).pushNamed(Login.tag);
    //   }).catchError((onError) => print(onError));
    // });
    // }
  }


  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        // backgroundColor: primary,
        key: _scaffoldKey,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
          new Image(
            image: new AssetImage("lib/assets/bg/image.png"),
            fit: BoxFit.cover,
          ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image(
                      image: AssetImage("lib/assets/icon/logo.png"),
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 30.0),
                      child: Text("Login If you have an Account",
                        style: subTitleWhite2(), textAlign: TextAlign.center,),
                    ),
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
                                    padding: EdgeInsets.only(left: 70.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'User Name',
                                        hintStyle: hintStyleDark(),
                                      ),
                                      style: hintStyleDark(),
                                       keyboardType: TextInputType.emailAddress,
                                      // validator: (String value) {
                                      //   if (value.isEmpty ||
                                      //       !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      //           .hasMatch(value)) {
                                      //     return 'Please enter a valid email';
                                      //   }
                                      // },
                                      // onSaved: (String value) {
                                      //   email = value;
                                      // },
                                    ),
                                  ),
                                  Positioned(
                                    top: -6.0,
                                    right: screenWidth * 0.72,
                                    child: Stack(
                                      fit: StackFit.loose,
                                      alignment: AlignmentDirectional.center,
                                      children: <Widget>[
                                        Image.asset("lib/assets/icon/send.png"),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 6.0, left: 13.0),
                                          child: Icon(FontAwesomeIcons.user, color: Colors.white, size: 16.0,),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(left: 70.0),
                                    child: TextFormField(
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                        hintStyle: hintStyleDark(),
                                      ),
                                      keyboardType: TextInputType.text,
                                      style: hintStyleDark(),
                                  //     validator: (String value) {
                                  //   if (value.isEmpty || value.length < 6) {
                                  //     return 'Password invalid';
                                  //   }
                                  // },
                                  // controller: _passwordTextController,
                                  // onSaved: (String value) {
                                  //   password = value;
                                  // },
                                  obscureText: true,
                                    ),
                                  ),
                                  Positioned(
                                    top: -6.0,
                                    right: screenWidth * 0.72,
                                    child: Stack(
                                      fit: StackFit.loose,
                                      alignment: AlignmentDirectional.center,
                                      children: <Widget>[
                                        Image.asset("lib/assets/icon/send.png"),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 6.0, left: 13.0),
                                          child: Icon(Icons.lock_outline, color: Colors.white, size: 18.0,),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Checkbox(
                                      value: value1,
                                      onChanged: onChangedValue1,
                                      activeColor: secondary,
                                    ),
                                    Text("Remember me", style: smallAddressWhite(),),
                                  ],
                                ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 15.0, start: 45.0, end: 45.0, bottom: 10.0),
                              child:  MaterialButton(
                                height: 45.0,
                                color: secondary,
                                textColor: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('LOGIN', style: categoryWhite()),
//                                   new Padding(
//                                     padding: new EdgeInsets.only(left: 5.0, right: 5.0),
//                                   ),
//                                   loading
//                                       ? new Image.asset(
//                                     'lib/assets/spinner.gif',
//                                     width: 19.0,
//                                     height: 19.0,
//                                   )
//                                       : new Text(''),
                                  ],
                                ),
                                onPressed: SignInUser,
                              //   () {
                              //  _scaffoldKey.currentState.showSnackBar(
                              //   new SnackBar(duration: new Duration(seconds: 2), content:
                              //   new Row(
                              //     children: <Widget>[
                              //       new CircularProgressIndicator(),
                              //       new Text("  Signing-In...")
                              //     ],
                              //   ),
                              //   ));
                              //   Navigator.of(context).pushNamed(Landing.tag);
                 
                              //   },
                                splashColor: secondary,
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(left: 4.0,top: 10.0,bottom: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                 children: <Widget>[
                                  Text("Or Sign In using", style: categoryWhite(),),
                                ],
                              )
                              
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  flex: 6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 50.0,
                                        width: 50.0,
                                        color: Colors.white,
                                        child: new Icon(FontAwesomeIcons.facebookF, color: Colors.grey.shade700,),
                                      ),
                                      Text("Facebook", style: subTitleWhite(),)
                                    ],
                                  ),
                                ),
//                                Padding(padding: new EdgeInsets.all(15.0)),
                                Flexible(
                                  flex: 6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 50.0,
                                        width: 50.0,
                                        color: Colors.white,
                                        child: new Icon(FontAwesomeIcons.twitter, color: Colors.grey.shade700,),
                                      ),
                                      Text("Twitter", style: subTitleWhite(),)
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            FlatButton(
                              padding: EdgeInsets.only(top:30.0),
                              onPressed: () {
                                Navigator.of(context).pushNamed(Register.tag);
                              },
                              child: Text("Don't have an Account ? Register", style: subTitleWhiteUnderline2(), ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
