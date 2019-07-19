import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/home/landing.dart';

class ResetPassword extends StatefulWidget {
  static String tag = "reset-password";
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: primary,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image(
              image: new AssetImage("lib/assets/bg/image.png"),
              fit: BoxFit.cover,
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
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
                      child: Text("Reset Password If you have an Account",
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
                              padding: EdgeInsets.only(bottom: 20.0),
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
                                          padding: EdgeInsets.only(bottom: 6.0, left: 3.0),
                                          child: Icon(Icons.lock_outline, color: Colors.white, size: 18.0,),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(left: 70.0),
                                    child: TextFormField(
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Confrim Password',
                                        hintStyle: hintStyleDark(),
                                      ),
                                      keyboardType: TextInputType.text,
                                      style: hintStyleDark(),
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
                                          padding: EdgeInsets.only(bottom: 6.0, left: 3.0),
                                          child: Icon(Icons.lock_outline, color: Colors.white, size: 18.0,),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 30.0, start: 45.0, end: 45.0, bottom: 10.0),
                              child:  MaterialButton(
                                height: 45.0,
                                color: secondary,
                                textColor: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('SUBMIT', style: categoryWhite()),
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
                                onPressed: () {
                                  Navigator.of(context).pushNamed(Landing.tag);
                                },
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
          ],
        )
    );
  }
}
