import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../style/style.dart';
import '../../screens/home/drawer.dart';
import '../../screens/home/landing.dart';
import '../../services/json.dart';
import '../../widgets/taskCard.dart';
import '../../screens/task/task_expanded.dart';

class CategoryExpanded extends StatefulWidget {
  static String tag = "category-expanded";
  final title;
  final time;
  CategoryExpanded({Key key, this.title, this.time}) : super(key: key);
  @override
  _CategoryExpandedState createState() => _CategoryExpandedState();
}

class _CategoryExpandedState extends State<CategoryExpanded> {

  double _value = 25.0;
  bool isChecked = false;

  bool value1 = true;

  void onChangedValue1(bool value) {
    setState(() {
      value1 = value;
    });
  }

  bool isPressed = false;

  _pressed() {
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
  // Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  // final TextEditingController _searchQuery = new TextEditingController();
  // bool  _isSearching = false;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime(2019),
    );
    if(picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  // void _handleSearchStart() {
  //   setState(() {
  //     _isSearching = true;
  //   });
  // }

  // void _handleSearchEnd() {
  //   setState(() {
  //     this.actionIcon = new Icon(Icons.search, color: Colors.white,);
  //     this.appBarTitle =
  //     new Text("", style: new TextStyle(color: Colors.white),);
  //     _isSearching = false;
  //     _searchQuery.clear();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(),
      appBar: AppBar(
          title: Row(
            children: <Widget>[
              InkWell(
                child: Text('${_date.day} / ${_date.month} / ${_date.year}', style: subTitleWhite(),),
                onTap: () {
                  _selectDate(context);
                },
              ),
              Icon(Icons.arrow_drop_down, color: Colors.white,),
            ],
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
      ),
      backgroundColor: bgGrey,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.center,
                height: 102.0,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 8.0,),
                      child: Text(widget.title, style: titleStyleLight(),),
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
                    Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 0.0, bottom: 5.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Tasks Completed:", style: categoryTitle(),),
                            Text("${_value.toInt()} %", style: redBoldText(),)
                          ],
                        )
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 2,
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
                                      title: data['tasks'][index]['title'], time: data['tasks'][index]['time'],
                                    ),
                              ),
                            );
                          },
                          child: TaskCard(title: data['tasks'][index]['title'], time: data['tasks'][index]['time'], isList: data['tasks'][index]['isList']),
                        ),
                      ],
                    );
                  }
              ),
              ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Divider(height: 10.0, color: bgGrey,),
                        PriorityTaskCard(title: data['tasks'][index]['title'], time: data['tasks'][index]['time'], isList: data['tasks'][index]['isList']),
                      ],
                    );
                  }
              ),
            ]
        ),
      ),
    );
  }
}
