import 'package:flutter/material.dart';
import 'package:todo_open/style/style.dart' as prefix0;
import '../../style/style.dart';
import '../../screens/auth/login.dart';

class ResetPassword extends StatefulWidget {
  static String tag = "reset-password";
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

  String password, confirmPassword;
  bool loading = false;

  resetPassword() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    } else {
      form.save();
      setState(() {
        loading = true;
      });
      if (confirmPassword.isNotEmpty && password.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      }
      setState(() {
        loading = false;
      });
      return;
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
                      child: Text(
                        "Reset Password If you have forgot password",
                        style: subTitleWhite2(),
                        textAlign: TextAlign.center,
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
                              padding: EdgeInsets.only(bottom: 20.0),
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
                              padding: EdgeInsets.only(bottom: 20.0),
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
                                onPressed: resetPassword,
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
        ),
      ),
    );
  }
}
