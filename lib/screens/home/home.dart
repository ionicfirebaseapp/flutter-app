import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/task/task_expanded.dart';
import '../../widgets/taskCard.dart';
import '../../services/json.dart';

class Home extends StatefulWidget {
  static String tag = "home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _value = 25.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: AlignmentDirectional.center,
              height: 80.0,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, top: 12.0, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Tasks Completed:",
                            style: categoryTitle(),
                          ),
                          Text(
                            "${_value.toInt()} %",
                            style: redBoldText(),
                          )
                        ],
                      )),
                  Slider(
                    value: _value,
                    min: 0.0,
                    max: 100.0,
                    divisions: 100,
                    label: "${_value.toInt()}",
                    activeColor: secondary,
                    inactiveColor: primary,
                    onChanged: (double value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data['tasks'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Divider(
                        height: 8.0,
                        color: bgGrey,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => TaskExpanded(
                                title: data['tasks'][index]['title'],
                                time: data['tasks'][index]['time'],
                              ),
                            ),
                          );
                        },
                        child: TaskCard(
                            title: data['tasks'][index]['title'],
                            time: data['tasks'][index]['time'],
                            isList: data['tasks'][index]['isList']),
                      ),
                    ],
                  );
                }),
            Divider(
              height: 10.0,
              color: bgGrey,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 8.0, bottom: 12.0, start: 15.0),
              child: Text(
                "Priorities This Week",
                style: primaryTextUnderline(),
              ),
            ),
            ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data['tasks'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Divider(
                        height: 10.0,
                        color: bgGrey,
                      ),
                      PriorityTaskCard(
                          title: data['tasks'][index]['title'],
                          time: data['tasks'][index]['time'],
                          isList: data['tasks'][index]['isList']),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
