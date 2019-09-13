import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../style/style.dart';
import '../../screens/home/landing.dart';
import '../../widgets/getPriorityTaskDetails.dart';

class PriorityTask extends StatefulWidget {
  static String tag = "priority-task";
  @override
  _PriorityTaskState createState() => _PriorityTaskState();
}

class _PriorityTaskState extends State<PriorityTask> {
  final f = new DateFormat('yyyy-month-dd');
  DateTime _date = new DateTime.now();
  final key = new GlobalKey<ScaffoldState>();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2020),
    );
    if (picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  Widget buildBar(BuildContext context) {
    return AppBar(
      title: Text(
        '${_date.day} / ${_date.month} / ${_date.year}',
        style: subTitleWhite(),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: primary,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(Landing.tag);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBar(context),
      backgroundColor: bgGrey,
      body: PriorityTaskDetails(),
    );
  }
}
