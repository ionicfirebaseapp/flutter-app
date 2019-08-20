import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../style/style.dart';
import '../../screens/home/landing.dart';
import '../../widgets/taskCard.dart';
import '../../services/json.dart';

class PriorityTask extends StatefulWidget {
  static String tag = "priority-task";
  @override
  _PriorityTaskState createState() => _PriorityTaskState();
}

class _PriorityTaskState extends State<PriorityTask> {
  bool projectCheck = false,
      homeCheck = false,
      projectMark = false,
      homeMark = false;
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
      title: InkWell(
        onTap: () {
          _selectDate(context);
        },
        child: Row(
          children: <Widget>[
            Text(
              '${_date.day} / ${_date.month} / ${_date.year}',
              style: subTitleWhite(),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ],
        ),
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
      body: ListView.builder(
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
    );
  }
}
