import 'package:flutter/material.dart';
import '../style/style.dart';

class AttachmentIcon extends StatefulWidget {
  final String title;
  final Widget icon;
  final String bg;
  AttachmentIcon({Key key, this.title, this.icon, this.bg}) : super(key: key);
  @override
  _AttachmentIconState createState() => _AttachmentIconState();
}

class _AttachmentIconState extends State<AttachmentIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            fit: StackFit.loose,
            alignment:
            AlignmentDirectional
                .center,
            children: <Widget>[
              Image.asset(widget.bg),
              widget.icon,
            ],
          ),
          Text(
            widget.title,
            style: category(),
          )
        ],
      ),
    );
  }
}
