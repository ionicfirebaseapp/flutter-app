import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/auth/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../screens/home/landing.dart';
import '../../services/firestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  static String tag = 'register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
 
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _passwordTextController = TextEditingController();

 String email, password,confirmPassword,name;
  Firestore store;
 @override
 void initState(){
   super.initState();
   callFireStore();
 }

  callFireStore() async {
    store = await fireStoreCommonService();
  }
  CollectionReference get users => store.collection('users');

  registration(){
    // final FormState form = _formKey.currentState;
    // print(email);
    // if (!form.validate()) {
    //   return;
    // } else {
    //   form.save();
      showDialog<Null>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text('wow..'),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text('You are registered successfully!!'),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('okay'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Landing.tag);

                  },
                ),
              ],
            );
          },
        );
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
      //  backgroundColor: primary,
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
                     image: new AssetImage("lib/assets/icon/logo.png"),
                   ),
                   Container(
                     alignment: FractionalOffset.center,
                     padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 30.0),
                     child: Text("Register, If you don't have an account",
                       style: subTitleWhite2(), textAlign: TextAlign.center,),
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
                                      //   final RegExp nameExp =
                                      //   new RegExp(r'^[A-Za-z ]+$');
                                      //   if (value.isEmpty || !nameExp.hasMatch(value)) {
                                      //     return 'Please enter your name';
                                      //   }
                                      // },
                                      // onSaved: (String value) {
                                      //   name = value;
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
                                         padding: EdgeInsets.only(bottom: 6.0, left: 15.0),
                                         child: Icon(FontAwesomeIcons.user, color: Colors.white, size: 16.0,),
                                       ),
                                     ],
                                   ),
                                 )
                               ],
                             ),
                           ),

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
                                       hintText: 'Email',
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
                                         padding: EdgeInsets.only(bottom: 6.0, left: 15.0),
                                         child: Icon(Icons.mail, color: Colors.white, size: 16.0,),
                                       ),
                                     ],
                                   ),
                                 )

                               ],
                             ),
                           ),

                           Container(
                             padding: EdgeInsets.only(bottom: 15.0),
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
                                  //   validator: (String value) {
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
                                         padding: EdgeInsets.only(bottom: 6.0, left: 15.0),
                                         child: Icon(Icons.lock_outline, color: Colors.white, size: 18.0,),
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
                                       hintText: 'Confirm Password',
                                       hintStyle: hintStyleDark(),
                                     ),
                                     keyboardType: TextInputType.text,
                                     style: hintStyleDark(),
                                     obscureText: true,
                                    //   validator: (String value) {
                                    // if (_passwordTextController.text != value) {
                                    //   return 'Passwords do not match.';
                                    // }
                                    // },
                                    // onSaved: (String value) {
                                    //   confirmPassword = value;
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
                                         padding: EdgeInsets.only(bottom: 6.0, left: 15.0),
                                         child: Icon(Icons.lock_outline, color: Colors.white, size: 18.0,),
                                       ),
                                     ],
                                   ),
                                 )
                               ],
                             ),
                           ),

                           Padding(
                             padding: const EdgeInsetsDirectional.only(top: 30.0, start: 45.0, end: 45.0, bottom: 10.0),
                             child:  MaterialButton(
                               height: 45.0,
                               color: secondary,
                               textColor: Colors.white,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                   Text('REGISTER', style: categoryWhite(),),
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
//                               onPressed: registration,
                               splashColor: secondary,
                             ),
                           ),

                           FlatButton(
                             onPressed: () {
                                   Navigator.of(context).pushNamed(Login.tag);
                             },
                             child: Text("Already have an Account ? Login", style: subTitleWhiteUnderline2(), ),
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

