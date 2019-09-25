import 'package:flutter/material.dart';
import 'package:todo_open/transitions/scale_route.dart';
import '../../style/style.dart';
import '../../screens/home/drawer.dart';
import 'package:intl/intl.dart';
import '../../screens/home/home.dart';
import '../../screens/task/add_task.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../transitions/scale_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  static String tag = "landing";
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> with SingleTickerProviderStateMixin {

  int currentTab = 0;
  Home pageOne = new Home();
  AddTask pageTwo = new AddTask();
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    pages = [
      pageOne,
      pageTwo,
    ];
    currentPage = pageOne;
  }

  Widget appBarTitle = Text('${DateFormat('d MMM yyyy').format(DateTime.now())}',
    style:  smallAddressWhite(),
  );
  Icon actionIcon = new Icon(Icons.search);
  final key = new GlobalKey<ScaffoldState>();
//  bool _IsSearching;
//  String _searchText = "";


//  void _searchPressed() {
//
//    setState(() {
//      if (this.actionIcon.icon == Icons.search) {
//        this.actionIcon = new Icon(Icons.close);
//        this.appBarTitle = new TextField(
//          style: new TextStyle(
//            color: Colors.white,
//          ),
//          decoration: new InputDecoration(
//              prefixIcon: new Icon(Icons.search, color: Colors.white, size: 14.0,),
//              hintText: "Search...",
//              hintStyle: subTitleWhite(),
//          ),
//        );
//        _handleSearchStart();
//      }
//      else {
//        _handleSearchEnd();
//      }
//    });
//  }

//  void _handleSearchStart() {
//    setState(() {
//      _IsSearching = true;
//    });
//  }
//
//  void _handleSearchEnd() {
//    setState(() {
//      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
//      this.appBarTitle =
//          Text('${DateFormat('d MMM yyyy').format(DateTime.now())}',
//            style:  smallAddressWhite(),
//          );
//      _IsSearching = false;
//      _searchQuery.clear();
//    });
//  }


  Widget buildBar(BuildContext context) {
    return AppBar(
        title:  appBarTitle,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primary,
        actions: <Widget>[
//           IconButton(
//             icon: Icon(FontAwesomeIcons.search, color: Colors.white, size: 14.0,),
//             onPressed: _searchPressed,
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
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 26.0,
          ),
          backgroundColor: secondary,
          mini: false,
          highlightElevation: 16.0,
          onPressed: () {
            Navigator.push(context, ScaleRoute(page: AddTask()));
//            Navigator.of(context).pushNamed(AddTask.tag);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: currentTab,
//        onTap: (int numTab) {
//          setState(() {
//            print("Current tab: " + numTab.toString());
//            currentTab = numTab;
//            currentPage = pages[numTab];
//          });
//        },
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home),
//            title: Text("Home"),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.add_circle),
//            title: Text("Add Task"),
//          ),
//        ],
//      ),
    );
  }
}
