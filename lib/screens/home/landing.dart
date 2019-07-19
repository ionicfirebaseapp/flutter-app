import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/home/drawer.dart';
import 'package:intl/intl.dart';
import '../../screens/home/home.dart';
import '../../screens/categories/categories.dart';
import '../../screens/task/add_task.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Landing extends StatefulWidget {
  static String tag = "landing";
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing>with SingleTickerProviderStateMixin  {

  final f = new DateFormat('yyyy-month-dd');
  DateTime _date = new DateTime.now();

  int currentTab = 0;
  Home pageOne = new Home();
  Categories pageTwo = new Categories();
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    pages = [pageOne, pageTwo,];
    currentPage = pageOne;
  }

  @override
  void dispose() {
    super.dispose();
  }

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

  Icon searchIcon = new Icon(Icons.search);
  Widget appBarTitle = Text("bv");


  void _searchPressed() {
    setState(() {
      print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
      if (this.searchIcon.icon == Icons.search) {
        this.searchIcon = new Icon(Icons.close);
        this.appBarTitle = new TextField(
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search, color: Colors.white, size: 14.0,),
              hintText: 'Search...'
          ),
        );
      } else {
        InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: Row(
            children: <Widget>[
              Text('${_date.day} / ${_date.month} / ${_date.year}', style: subTitleWhite(),),
              Icon(Icons.arrow_drop_down, color: Colors.white,),
            ],
          ),
        );
      }
    });
  }

  Widget buildBar(BuildContext context) {

//    Widget appBarTitle = InkWell(
//      onTap: () {
//        _selectDate(context);
//      },
//      child: Row(
//        children: <Widget>[
//          Text('${_date.day} / ${_date.month} / ${_date.year}', style: subTitleWhite(),),
//          Icon(Icons.arrow_drop_down, color: Colors.white,),
//        ],
//      ),
//    );

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
//        title: appBarTitle,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primary,
         actions: <Widget>[
//           IconButton(
//             icon: Icon(FontAwesomeIcons.search, color: Colors.white, size: 14.0,),
//             onPressed: _searchPressed,
//           ),
//           IconButton(
//             icon: Icon(FontAwesomeIcons.ellipsisV, color: Colors.white, size: 14.0,),
//             onPressed: () {},
//           ),
         ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBar(context),
      drawer: DrawerList(),
      backgroundColor: bgGrey,
      body: currentPage,
      floatingActionButton: FloatingActionButton(
          elevation: 6.0,
          child: Icon(Icons.add, color: Colors.white, size: 26.0,),
          backgroundColor: secondary,
          mini: false,
          highlightElevation: 16.0,
          onPressed: () {
            Navigator.of(context).pushNamed(AddTask.tag);
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int numTab) {
          setState(() {
            print("Current tab: " + numTab.toString());
            currentTab = numTab;
            currentPage = pages[numTab];
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text("Categories"),
          ),
        ],
      ),
    );
  }

}