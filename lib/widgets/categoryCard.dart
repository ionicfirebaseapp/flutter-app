import 'package:flutter/material.dart';
import '../style/style.dart';
import '../screens/task/add_task.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final String icon;
  final String isLast;
  CategoryCard({Key key, this.title, this.icon, this.isLast}) : super(key: key);
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return widget.isLast == "no"
        ? Container(
            margin: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 20.0,
            ),
            color: Colors.white,
            width: 175.0,
            height: 240.0,
            alignment: AlignmentDirectional.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsetsDirectional.only(top: 20.0),
                  width: 89.0,
                  height: 89.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.grey.shade50,
                  ),
                  child: Image.asset(widget.icon),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Text(
                    widget.title,
                    style: categoryTitle2(),
                  ),
                ),
              ],
            ))
        : InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AddTask.tag);
            },
            child: Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 20.0,
                ),
                color: Colors.white,
                width: 175.0,
                height: 240.0,
                alignment: AlignmentDirectional.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 89.0,
                      height: 89.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.grey.shade400,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ),
                  ],
                )));
  }
}
