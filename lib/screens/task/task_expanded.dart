import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../services/json.dart';
import '../../widgets/checkboxTile.dart';

class TaskExpanded extends StatefulWidget {
  static String tag = "task-expanded";
  final title;
  final time;
  TaskExpanded({Key key, this.title, this.time}) : super(key: key);
  @override
  _TaskExpandedState createState() => _TaskExpandedState();
}

class _TaskExpandedState extends State<TaskExpanded> {
  bool isChecked = false;

  bool isFav = false;

  _favorites() {
    var newVal = true;
    if(isFav) {
      newVal = false;
    } else {
      newVal = true;
    }
    setState((){
      isFav = newVal;
    });
  }

  bool isNotificationOn = false;

  _notificationOn() {
    var newVal = true;
    if(isNotificationOn) {
      newVal = false;
    } else {
      newVal = true;
    }
    setState((){
      isNotificationOn = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text(widget.title, style: titleBlack(),),
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
                        padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
                        child: Text(widget.time, style: category(),),
                      ),
                      Divider(height: 1.0, color: border,),
                    ],
                  )
                ),
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
                                isFav ? Icons.star:Icons.star_border,
                                size: 24.0,
                                color: secondary
                            ),
                            backgroundColor: Colors.white,
                            heroTag: null,
                            onPressed: _favorites,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: FloatingActionButton(
                            elevation: 3.0,
                            mini: true,
                            child: Icon(
                                isNotificationOn ? Icons.notifications:Icons.notifications_none,
                                size: 24.0,
                                color: tertiary
                            ),
                            backgroundColor: Colors.white,
                            heroTag: null,
                            onPressed: _notificationOn,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data['subTasks'].length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxTile(title: data['subTasks'][index]['title'],);
              }
          ),

        ],
      ),
    );
  }
}