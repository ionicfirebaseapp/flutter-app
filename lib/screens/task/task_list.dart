import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../style/style.dart';
import '../../screens/task/task_expanded.dart';
import '../../screens/home/drawer.dart';
import '../../screens/home/landing.dart';
import '../../widgets/taskCard.dart';

class TaskList extends StatefulWidget {
  static String tag = "task-list";
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  bool isChecked, project = false, practice = false, work = false, grocery = false,cmpProject = false, doc = false;
  bool projectMark = false, practiceMark = false, workMark = false;
  double _value = 20.0;

  bool value1 = true;

  void onChangedValue1(bool value) {
    setState(() {
      value1 = value;
    });
  }

  bool isPressed = false;

  void _pressed() {
    var newVal = true;
    if(isPressed) {
      newVal = false;
    } else {
      newVal = true;
    }
    setState((){
      isPressed = newVal;
    });
  }

  final f = new DateFormat('yyyy-month-dd');
  DateTime _date = new DateTime.now();

  Widget appBarTitle = new Text("", style: new TextStyle(color: Colors.white),);
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  bool  _isSearching = false;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2020),
    );
    if(picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  Widget buildBar(BuildContext context) {
    return AppBar(
      elevation: 4.0,
        title: InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: Row(
            children: <Widget>[
              Text('${_date.day} / ${_date.month} / ${_date.year}', style: subTitleWhite(),),
              Icon(Icons.arrow_drop_down, color: Colors.white,),
            ],
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primary,
        actions: <Widget>[
          // new IconButton(icon: actionIcon, onPressed: () {
          //   setState(() {
          //     if (this.actionIcon.icon == Icons.search) {
          //       this.actionIcon = new Icon(Icons.close, color: Colors.white,);
          //       this.appBarTitle = new Theme(
          //         data: new ThemeData(
          //           brightness: Brightness.dark,
          //           accentColor: primary,
          //         ),
          //         child: new TextField(
          //           controller: _searchQuery,
          //           style: subTitleWhite(),
          //           decoration: new InputDecoration(
          //               prefixIcon: new Icon(Icons.search, color: Colors.white),
          //               hintText: "Search...",
          //               hintStyle: new TextStyle(color: Colors.white)
          //           ),
          //         ),
          //       );
          //       _handleSearchStart();
          //     }
          //     else {
          //       _handleSearchEnd();
          //     }
          //   });
          // },),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white,),
            onPressed: () {
              Navigator.of(context).pushNamed(Landing.tag);
            },
          ),
        ]
    );
  }


  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text("", style: new TextStyle(color: Colors.white),);
      _isSearching = false;
      _searchQuery.clear();
    });
  }

  List<Map<String, String>> tasks = [
    {
      'title': 'Grocery Store',
      'isList': 'yes',
      'time': '24 Sep, 8:30 pm'
    },
    {
      'title': 'Grocery Store2',
      'isList': 'yes',
      'time': '24 Sep, 9:30 pm'
    },
    {
      'title': 'Grocery Store3',
      'isList': 'no',
      'time': '24 Sep, 12:30 pm'
    },
    {
      'title': 'Grocery Store4',
      'isList': 'yes',
      'time': '24 Sep, 8:30 pm'
    }
  ];

  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: DrawerList(),
      appBar: buildBar(context),
      backgroundColor: bgGrey,
      body: ListView(
          children: <Widget>[
            Container(
              height: 117.0,
              width: screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/bg/bar.png"),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.only(left: 30.0, top: 18.0, bottom: 16.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Need to find my ID Card", style: subTitleUnderline(),),
                      Container(
                        margin: EdgeInsets.only(top: 6.0),
                        height: 3.0,
                        width: screenWidth*0.4,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 5.0, right: 2.0, bottom: 11.0),
                            child: Icon(Icons.fiber_manual_record, color: Colors.purpleAccent, size: 6.0,),),
                          Text("Work", style: subTitleWhite(),)
                        ],
                      ),
                      Text("9:00 am", style: subTitleWhite(),)
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 10.0, bottom: 10.0, start: 15.0),
              child: Text("Others Tasks todo", style: primaryTextUnderline(),),
            ),
            ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Divider(height: 10.0, color: bgGrey,),
                      PriorityTaskCard(title: tasks[index]['title'], time: tasks[index]['time'], isList: tasks[index]['isList']),
                    ],
                  );
                }
            ),
            Divider(height: 10.0, color: bgGrey,),
            Container(
              alignment: AlignmentDirectional.center,
              height: 80.0,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 12.0, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Tasks Completed:", style: categoryTitle(),),
                          Text("${_value.toInt()} %", style: redBoldText(),)
                        ],
                      )
                  ),
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
            Divider(height: 10.0, color: bgGrey,),
            ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Divider(height: 8.0, color: bgGrey,),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TaskExpanded(
                                    title: tasks[index]['title'], time: tasks[index]['time'],
                                  ),
                            ),
                          );
                        },
                        child: TaskCard(title: tasks[index]['title'], time: tasks[index]['time'], isList: tasks[index]['isList']),
                      ),
                    ],
                  );
                }
            ),

          ],
        ),
    );
  }
}
