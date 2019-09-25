import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_open/style/style.dart';
import '../style/style.dart';
import '../screens/task/task_expanded.dart';
import '../services/crud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../screens/task/add_task.dart';
import '../screens/home/landing.dart';
import '../animations/fade_in_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedTaskDetails extends StatefulWidget {
  @override
  _CompletedTaskDetailsState createState() => _CompletedTaskDetailsState();
}

class _CompletedTaskDetailsState extends State<CompletedTaskDetails> {
  crudMedthods crudObj = new crudMedthods();
  var tasks;

  bool taskCompleted = false;
  @override
  void initState() {
    getInfo();
    super.initState();
  }

  String uid, fbId, twId;
  var loginType;

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
    crudObj.getData(loginType == 'fs' ? uid : loginType == 'fb' ? fbId : twId).then((results) {
      if(mounted){
        setState(() {
          tasks = results;
        });
      }
    });
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {

    Widget _tasksList() {
      if (tasks != null) {
        return Container(
          child: StreamBuilder(
              stream: tasks,
              builder: (context, snapshot) {
                if (snapshot.data != null && snapshot.data.documents.length>0) {
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return snapshot.data.documents[index]['completed'] == true ? Column(
                          children: <Widget>[
                            Divider(
                              height: 10.0,
                              color: bgGrey,
                            ),
                            FadeIn(
                              0.0 + index/2,
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => TaskExpanded(
                                        updateDocId: snapshot.data.documents[index].documentID,
                                      ),
                                    ),
                                  );
                                },
                                child: Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.3,
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    height: 80.0,
                                    color: Colors.white,
                                    child: ListTile(
                                      leading: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "${snapshot.data.documents[index]['dateTime'].split("-")[1].split(" ")[2]} "
                                                "${snapshot.data.documents[index]['dateTime'].split("-")[1].split(" ")[3]}",
                                            style: textStyleOrangeSS(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              snapshot.data.documents[index]['dateTime'].split("-")[0],
                                              style: subTitleDarkSS(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      title: Text(
                                        snapshot.data.documents[index]['taskTitle'],
                                        style: subTitle(),
                                      ),
                                      subtitle: Text(
                                        snapshot.data.documents[index]['category'],
                                        style: smallAddressSS(),
                                      ),
                                    ),
                                  ),
//                                actions: <Widget>[
//                                  Container(
//                                    color: orange,
//                                    child: InkWell(
//                                      onTap: () {
//                                        setState(() {
//                                          taskCompleted = true;
//                                        });
//                                        crudObj.updateData(snapshot.data.documents[index].documentID, {
//                                          'completed': this.taskCompleted,
//                                        });
//                                      },
//                                      child: Column(
//                                        mainAxisAlignment: MainAxisAlignment.center,
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Image.asset("lib/assets/icon/checked.png"),
//                                          Padding(
//                                            padding: const EdgeInsets.only(top: 7.0),
//                                            child: Text("Completed", style: subTitleWhite2SR(),),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ],
                                  secondaryActions: <Widget>[
                                    Container(
                                      color: primary,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => AddTask(
                                                  update: true, updateDocId: snapshot.data.documents[index].documentID,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.pencilAlt, size: 18.0, color: Colors.white),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 7.0),
                                              child: Text("Edit", style: subTitleWhite2SR(),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: primary,
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            crudObj.deleteData(snapshot.data.documents[index].documentID, loginType == 'fs' ? uid : loginType == 'fb' ? fbId : twId);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => Landing(
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset("lib/assets/icon/delete.png"),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 2.0),
                                                child: Text("Delete", style: subTitleWhite2SR(),),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ) : Container();
                      });
                } else {
                  return Column(
                    children: <Widget>[
                      FadeIn(2, CardPlaceholder()),
                      FadeIn(1.5, Text("Tasks not added yet...")),
                    ],
                  );
                }
              }),
        );
      } else {
        return Column(
          children: <Widget>[
            FadeIn(1, CardPlaceholder()),
            FadeIn(1.5, Text("Tasks not added yet...")),
          ],
        );
      }
    }

    return Container(
      child: _tasksList(),
    );
  }
}
