import 'package:flutter/material.dart';
import '../style/style.dart';

class CheckboxTile extends StatefulWidget {
  final title;
  CheckboxTile({
    Key key,
    this.title,
  }) : super(key: key);
  @override
  _CheckboxTileState createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: isChecked,
      onChanged: (bool value) {
        setState(() {
          isChecked = !isChecked;
        });
      },
      activeColor: tertiary,
      title: Text(
        widget.title,
        style: roundButton(),
      ),
    );
  }
}
