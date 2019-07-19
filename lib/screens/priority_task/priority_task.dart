import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../style/style.dart';
import '../../screens/home/landing.dart';
import '../../widgets/taskCard.dart';

class PriorityTask extends StatefulWidget {
  static String tag = "priority-task";
  @override
  _PriorityTaskState createState() => _PriorityTaskState();
}

class _PriorityTaskState extends State<PriorityTask> {
   bool projectCheck = false, homeCheck = false, projectMark = false, homeMark = false;
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
  Widget build(BuildContext context){
    return Scaffold(
      appBar: buildBar(context),
      backgroundColor: bgGrey,
      body: ListView.builder(
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
    );
  }
}