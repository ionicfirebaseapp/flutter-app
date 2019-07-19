import 'package:flutter/material.dart';
import '../../style/style.dart';
import 'package:intl/intl.dart';

class MyAppBar extends AppBar {
  MyAppBar({Key key, Widget title})
      : super(key: key, title: title, actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_vert, color: Colors.white,),
          onPressed: () {},
            ),
  ]);
}

class MyAppbar extends StatefulWidget {
  @override
  _MyAppbarState createState() => _MyAppbarState();
}

class _MyAppbarState extends State<MyAppbar> {

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        automaticallyImplyLeading: true,
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
            new IconButton(icon: actionIcon, onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                  this.appBarTitle = new Theme(
                    data: new ThemeData(
                      brightness: Brightness.dark,
                      accentColor: primary,
                    ),
                    child: new TextField(
                      controller: _searchQuery,
                      style: subTitleWhite(),
                      decoration: new InputDecoration(
                          prefixIcon: new Icon(Icons.search, color: Colors.white),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.white)
                      ),
                    ),
                  );
                  _handleSearchStart();
                }
                else {
                  _handleSearchEnd();
                }
              });
            },),
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white,),
              onPressed: () {},
            ),
          ]
      ),
    );
  }
}

