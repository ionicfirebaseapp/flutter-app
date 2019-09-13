import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  final String title;
  final Color color;
  final bool selected;
  CategoryButton({Key key, this.title, this.color, this.selected }) : super(key: key);
  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
//      margin: EdgeInsets.symmetric(horizontal: 12.0),
      child: RaisedButton(
        child: new Text(widget.title, style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
          color: widget.selected ? Colors.white : Colors.black87,
          letterSpacing: 1.0,
          fontFamily: 'OpenSansSemiBold',
        ),),
        elevation: 0.0,
        color: widget.selected ? widget.color : Colors.grey.shade50,
      ),
    );
  }
}
