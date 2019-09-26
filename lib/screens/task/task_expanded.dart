import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix1;
import 'package:todo_open/style/style.dart' as prefix0;
import '../../style/style.dart';
import '../../services/crud.dart';
import '../../screens/home/landing.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskExpanded extends StatefulWidget {
  static String tag = "task-expanded";
  final String updateDocId;
  bool priorityTask;
  var id;
  TaskExpanded({Key key,this.updateDocId, this.priorityTask, this.id}) : super(key: key);
  @override
  _TaskExpandedState createState() => _TaskExpandedState();
}

class _TaskExpandedState extends State<TaskExpanded> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  crudMedthods crudObj = new crudMedthods();

  bool isPriority = false;
  bool doNotify = false;
  var tasks;
  String taskDetail;
  String docId;

  @override
  void initState() {
    crudObj.getTaskData(widget.updateDocId, widget.id).then((results) {
      setState(() {
        tasks = results;
      });
    });
//    getInfo();
//    docId = widget.updateDocId;
    super.initState();
  }

  bool isNotificationOn = false;

  saveDetails() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    } else {
      form.save();
      crudObj.updateData(widget.updateDocId, loginType == 'fs' ? uid : loginType == 'fb' ? fbId : twId,{
        'taskDetail': this.taskDetail,
      });
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text('Task Details Updated successfully...!!!'),
            duration: Duration(seconds: 2),
          ));

    }
  }

  var fbId, uid, loginType, twId;

  getInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginType = prefs.getString('loginType');
    });
    print("logintype ...................$loginType");
    if(loginType == 'fb'){
      setState(() {
        fbId = prefs.getString('fbId');
      });
      print('fbbuser $fbId');
    }else if(loginType == 'tw'){
      setState(() {
        twId = prefs.getString('twId');
      });
      print('twuser $twId');
    }else if(loginType == 'fs') {
      final FirebaseUser userProfile = await FirebaseAuth.instance.currentUser();
      if (userProfile != null) {
        uid = userProfile.uid;
      }
      print('user name ....................$uid');
    }
    crudObj.getTaskData(docId, loginType == 'fs' ? uid : loginType == 'fb' ? fbId : twId).then((results) {
      setState(() {
        tasks = results;
      });
    });
  }

  Widget _taskData() {
    if (tasks != null) {
      return SingleChildScrollView(
        child: Container(
          child: StreamBuilder(
              stream: tasks,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return TaskData(snapshot.data);
                } else {
                  return Container(
                    child: Text("error"),
                  );
                }
              }),
        ),
      );
    } else {
      return Container(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget TaskData(data) {
    return  data == null || data == [] ? Container() :
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ListTile(
          title: Text(
            data['taskTitle'],
            style: titleBlack(),
          ),
          subtitle: Text(
            data['category'],
            style: smallAddress(),
          ),
        ),
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                  height: 50.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 4.0, bottom: 4.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              data['dateTime'].split('-')[0],
                              style:  textStyleOrangeSS(),
                            ),
                            Text(
                              data['dateTime'].split('-')[1],
                              style: textStyleGreySS(),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1.0,
                        color: border,
                      ),
                    ],
                  )),
              Positioned(
                right: 0.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: FloatingActionButton(
                        elevation: 3.0,
                        mini: true,
                        child: Icon(
                            data['priorityTask'] ? Icons.star : Icons.star_border,
                            size: 24.0, color: secondary),
                        backgroundColor: Colors.white,
                        heroTag: null,
                        onPressed: (){
                          setState(() {
                            isPriority =! isPriority;
                            try{
                              crudObj.updateData(widget.updateDocId, widget.id,{
                                'priorityTask' : this.isPriority
                              });
                              print('pppppppppppppppppppppppppp $isPriority');
                              if(isPriority == true) {
                                _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.blueGrey,
                                      content: Text(
                                          'Task Added to Priority successfully...!!!'),
                                      duration: Duration(seconds: 2),
                                    ));
                              }else if(isPriority == false){
                                _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.blueGrey,
                                      content: Text(
                                          'Task Removed from Priority successfully...!!!'),
                                      duration: Duration(seconds: 2),
                                    ));
                              }
                            }catch(e) {
                              print(e);
                            }
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: FloatingActionButton(
                        elevation: 3.0,
                        mini: true,
                        child: Icon(
                            Icons.delete_outline,
                            size: 24.0,
                            color: tertiary),
                        backgroundColor: Colors.white,
                        heroTag: null,
                        onPressed: (){
                          setState(() {
                            try{
                              Navigator.pop(context);
                              crudObj.deleteData(widget.updateDocId, widget.id);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Landing(
                                  ),
                                ),
                              );
                            }catch(e) {
                              print(e);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: data['dueDate'] != null ? Row(
            children: <Widget>[
              Text("Due Date: ", style: redBoldText(),),
              Text(data['dueDate'], style: productTitle(),)
            ],
          ) : Container(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text("About your task:", style: prefix0.subBoldTitleUnderline(),),
        ),
        Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintStyle: hintStyleDark(),
              ),
              initialValue: data['taskDetail'],
              keyboardType: TextInputType.text,
              maxLines: 10,
              style: subTitleBlack(),

              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your Task Detail';
                }
              },
              onSaved: (value) {
                this.taskDetail = value;
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _taskData(),
      bottomNavigationBar: InkWell(
        onTap: saveDetails,
        child: Container(
          color: secondary,
          padding: new EdgeInsets.all(15.0),
          child: new Text(
            "SAVE",
            style: categoryWhite(),
            textAlign: TextAlign.center,
          ),
        ),
      )
    );
  }
}
