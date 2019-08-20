import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../style/style.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String time;
  final String isList;
  TaskCard({Key key, this.title, this.time, this.isList}) : super(key: key);
  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool grocery = false;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        alignment: AlignmentDirectional.center,
        height: 70.0,
        color: Colors.white,
        child: ListTile(
          leading: Checkbox(
            value: grocery,
            onChanged: (bool value) {
              setState(() {
                grocery = !grocery;
              });
            },
            activeColor: tertiary,
          ),
          title: Text(
            widget.title,
            style: roundButton(),
          ),
          subtitle: Text(
            widget.time,
            style: smallAddress(),
          ),
          trailing: widget.isList != 'no'
              ? Icon(
                  Icons.folder_open,
                  size: 16.0,
                )
              : Icon(
                  Icons.add,
                  color: Colors.white,
                ),
        ),
      ),
      secondaryActions: <Widget>[
        Container(
          color: primary,
          child: Center(
            child: InkWell(
              onTap: () {
//                Navigator.of(context).pushNamed(AddTask.tag);
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(FontAwesomeIcons.pencilAlt,
                    size: 16.0, color: tertiary),
              ),
            ),
          ),
        ),
        Container(
          color: primary,
          child: Center(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(FontAwesomeIcons.solidTrashAlt,
                    size: 16.0, color: tertiary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriorityTaskCard extends StatefulWidget {
  final String title;
  final String time;
  final String isList;
  PriorityTaskCard({Key key, this.title, this.time, this.isList})
      : super(key: key);
  @override
  _PriorityTaskCardState createState() => _PriorityTaskCardState();
}

class _PriorityTaskCardState extends State<PriorityTaskCard> {
  bool projectPriority = false, projectMark = false;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        alignment: AlignmentDirectional.center,
        height: 80.0,
        color: Colors.white,
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: projectPriority,
          onChanged: (bool value) {
            setState(() {
              projectPriority = !projectPriority;
            });
          },
          activeColor: tertiary,
          title: Text(
            widget.title,
            style: roundButton(),
          ),
          subtitle: Text(
            widget.time,
            style: smallAddress(),
          ),
          secondary: IconButton(
            icon: Icon(
              projectMark ? Icons.star : Icons.star_border,
              size: 22.0,
              color: secondary,
            ),
            onPressed: () => setState(
              () {
                projectMark = !projectMark;
              },
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        Container(
          color: primary,
          child: Center(
            child: InkWell(
              onTap: () {
//                Navigator.of(context).pushNamed(AddTask.tag);
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(FontAwesomeIcons.pencilAlt,
                    size: 16.0, color: tertiary),
              ),
            ),
          ),
        ),
        Container(
          color: primary,
          child: Center(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(FontAwesomeIcons.solidTrashAlt,
                    size: 16.0, color: tertiary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
