import 'package:flutter/material.dart';
import '../style/style.dart';
import '../screens/task/task_expanded.dart';
import '../services/crud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../screens/home/landing.dart';
import '../screens/task/add_task.dart';
import '../animations/fade_in_ui.dart';


class PriorityTaskDetails extends StatefulWidget {
  @override
  _PriorityTaskDetailsState createState() => _PriorityTaskDetailsState();
}

class _PriorityTaskDetailsState extends State<PriorityTaskDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isChecked = false, isPriority = false;
  crudMedthods crudObj = new crudMedthods();
  var tasks;

  @override
  void initState() {
    crudObj.getData().then((results) {
      if(mounted){
        setState(() {
          tasks = results;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget priorityTasksList() {
      if (tasks != null) {
        return Container(
          key: _scaffoldKey,
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
                        return snapshot.data.documents[index].data['priorityTask'] && snapshot.data.documents[index].data['completed'] != true ?
                        Column(
                          children: <Widget>[
                            Divider(
                              height: 8.0,
                              color: bgGrey,
                            ),
                            FadeIn(
                              1.0+index,
                              Slidable(
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
                                    trailing: IconButton(
                                        icon: Icon(
                                            snapshot.data.documents[index]['priorityTask'] ? Icons.star : Icons.star_border,
                                            size: 24.0, color: secondary),
                                        onPressed: (){
                                          setState(() {
                                            isPriority =! isPriority;
                                            try{
                                              crudObj.updateData(snapshot.data.documents[index].documentID, {
                                                'priorityTask' : this.isPriority
                                              });
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: new Text("Updated Successfuly...!!!"),
                                                    content: new Text("Task has been Updated"),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                        child: new Text("Close"),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }catch(e) {
                                              print(e);
                                            }
                                          });
                                        }
                                    ),
                                  ),
                                ),
                                secondaryActions: <Widget>[
                                  Container(
                                    color: primary,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) => AddTask(
                                                update: true, updateDocId: snapshot.data.documents[index].documentID
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
                                          crudObj.deleteData(snapshot.data.documents[index].documentID);
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
            FadeIn(2, CardPlaceholder()),
            FadeIn(1.5, Text("Tasks not added yet...")),
          ],
        );
      }
    }

    return priorityTasksList();
  }
}
