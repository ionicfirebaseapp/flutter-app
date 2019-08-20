import 'package:flutter/material.dart';
import '../../style/style.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:scheduled_notifications/scheduled_notifications.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import '../../screens/task/recorder.dart';
import 'dart:async';

class AddTask extends StatefulWidget {
  static String tag = "add-task";
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formatter = new DateFormat('yyyy-MM-dd');
  bool calender = false,
      chat = false,
      ring = false,
      attach = false,
      starMark = false,
      mic = false;
  String error;

  bool currentWidget = true;
  TimeOfDay _time = new TimeOfDay.now();
  Image image1;

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
    }
  }

  final f = new DateFormat('yyyy-month-dd');
  DateTime _date = new DateTime.now();

  bool pressAttention = false;
  bool chooseWork = false,
      choosePersonal = false,
      chooseMeeting = false,
      chooseHome = false,
      chooseTime = false;

  bool _value = false;
  onChanged(bool value) {
    setState(
      () {
        _value = value;
      },
    );
  }

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
    Navigator.pop(context);
  }

  bool visibilityTag = false;
  bool visibilityObs = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag") {
        visibilityTag = visibility;
      }
      if (field == "obs") {
        visibilityObs = visibility;
      }
    });
  }

  static File _imageFile;

  takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = image;
    });
    print(_imageFile);
  }

  selectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = image;
    });
  }

  addAlarm() {
    setState(() {
      _value = true;
    });
    if (_value) {
      _scheduleNotificationAlert();
    }
  }

  String _filePath;

  void getFilePath() async {
    String filePath = await FilePicker.getFilePath(type: FileType.ANY);
    if (filePath == '') {
      return;
    }
    print("File path: " + filePath);
    setState(() {
      this._filePath = filePath;
    });
  }

  void getAudio() async {
    String filePath = await FilePicker.getFilePath(type: FileType.AUDIO);
    if (filePath == '') {
      return;
    }
    print("File path: " + filePath);
    setState(() {
      this._filePath = filePath;
    });
  }

  _scheduleNotificationAlert() async {
    await ScheduledNotifications.scheduleNotification(
        new DateTime.now().add(new Duration(seconds: 5)).millisecondsSinceEpoch,
        "Ticker text",
        "Alarm",
        "alarm is snoozed");
    Navigator.pop(context);
  }

  _scheduleNotification() async {
    int notificationId = await ScheduledNotifications.scheduleNotification(
        new DateTime.now().add(new Duration(seconds: 5)).millisecondsSinceEpoch,
        "Ticker text",
        "Content title",
        "Content");
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Task",
          style: titleStyleBoldLight(),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        bottomOpacity: 0.0,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close, color: Colors.black87, size: 22.0),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsetsDirectional.only(start: 10.0),
                child: TextFormField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Task Title',
                      hintStyle: hintStyleDark(),
                    ),
                    keyboardType: TextInputType.text,
                    style: titleStyleBoldLight()),
              ),
              Divider(
                color: Colors.grey.shade500,
                height: 10.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new RaisedButton(
                    child: new Text(
                      'Work',
                      style: subTitleBlack(),
                    ),
                    textColor: chooseWork ? Colors.white : Colors.black87,
                    elevation: 0.0,
                    disabledTextColor: Colors.blueAccent,
                    disabledColor: Colors.white,
//                    color: primary,
                    color: chooseWork ? primary : Colors.grey.shade300,
                    onPressed: () {
                      setState(() => chooseWork = !chooseWork);
                    },
                  ),
                  new RaisedButton(
                    child: new Text(
                      'Personal',
                      style: subTitleBlack(),
                    ),
                    textColor: Colors.black87,
                    elevation: 0.0,
                    color: choosePersonal ? primary : Colors.grey.shade300,
                    onPressed: () =>
                        setState(() => choosePersonal = !choosePersonal),
                  ),
                  new RaisedButton(
                    child: new Text(
                      'Meet',
                      style: subTitleBlack(),
                    ),
                    textColor: Colors.black87,
                    elevation: 0.0,
                    color: chooseMeeting ? primary : Colors.grey.shade300,
                    onPressed: () =>
                        setState(() => chooseMeeting = !chooseMeeting),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Home',
                          style: subTitleBlack(),
                        ),
                      ],
                    ),
                    textColor: Colors.black87,
                    elevation: 0.0,
                    disabledTextColor: Colors.blueAccent,
                    disabledColor: Colors.white,
//                    color: primary,
                    color: chooseHome ? primary : Colors.grey.shade300,
                    onPressed: () => setState(() => chooseHome = !chooseHome),
                  ),
                  RaisedButton(
                    child: Text(
                      'Free time',
                      style: subTitleBlack(),
                    ),
                    textColor: Colors.black87,
                    elevation: 0.0,
                    color: chooseTime ? primary : Colors.grey.shade300,
                    onPressed: () => setState(() => chooseTime = !chooseTime),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey.shade500,
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.calendar_today),
                      color:
                          calender ? Colors.blueAccent : Colors.grey.shade400,
                      onPressed: () {
                        setState(() => calender = !calender);
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                    color: primary,
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'ADD DUE DATE',
                                      textAlign: TextAlign.center,
                                      style: categoryWhite(),
                                    )),
                              );
                            });
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.chat,
                      ),
                      color: chat ? primary : Colors.grey.shade400,
                      onPressed: () {
                        setState(() => chat = !chat);
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return InkWell(
                                onTap: () {
                                  visibilityTag ? null : _changed(true, "tag");
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    color: primary,
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      'ADD SUB TASK',
                                      textAlign: TextAlign.center,
                                      style: categoryWhite(),
                                    )),
                              );
                            });
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.notifications,
                      ),
                      color: ring ? Colors.red : Colors.grey.shade400,
                      onPressed: () {
                        setState(() => ring = !ring);
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 215.0,
                                child: ListView(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: primary,
                                      padding: EdgeInsets.all(5.0),
                                      child: MaterialButton(
                                          onPressed: addAlarm,
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            'ADD ALARM',
                                            textAlign: TextAlign.center,
                                            style: categoryWhite(),
                                          )),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${formatter.format(DateTime.now())}',
                                            textAlign: TextAlign.center,
                                            style: titleStyleBoldLight(),
                                          ),
                                          InkWell(
                                            onTap: _scheduleNotification,
                                            child: Text(
                                              'Set',
                                              textAlign: TextAlign.center,
                                              style: address(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${_time.format(context)}',
                                            textAlign: TextAlign.center,
                                            style: titleStyleBoldLight(),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                _selectTime(context);
                                              },
                                              child: Icon(
                                                  Icons.keyboard_arrow_down)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(0.0),
                                      child: SwitchListTile(
                                        title: Text(
                                          "Snooze",
                                          style: titleStyleBoldLight(),
                                        ),
                                        value: _value,
                                        onChanged: (bool value) {
                                          onChanged(value);
                                        },
                                        activeColor: primary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.attach_file,
                      ),
                      color: attach ? Colors.blueAccent : Colors.grey.shade400,
                      onPressed: () {
                        setState(() => attach = !attach);
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 250.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                            color: primary,
                                            width: screenWidth,
                                            padding: EdgeInsets.all(20.0),
                                            child: Text(
                                              'ADD ATTACHMENT',
                                              textAlign: TextAlign.center,
                                              style: categoryWhite(),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              getFilePath();
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Stack(
                                                  fit: StackFit.loose,
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: <Widget>[
                                                    Image.asset(
                                                        "lib/assets/icon/purple.png"),
                                                    Icon(
                                                        Icons.insert_drive_file,
                                                        size: 22.0,
                                                        color: Colors.white),
                                                  ],
                                                ),
                                                Text(
                                                  "Documents",
                                                  style: category(),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                takeImage();
                                              },
                                              child: Column(
                                                children: <Widget>[
                                                  Stack(
                                                    fit: StackFit.loose,
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                          "lib/assets/icon/orange.png"),
                                                      Icon(Icons.camera_alt,
                                                          size: 22.0,
                                                          color: Colors.white),
                                                    ],
                                                  ),
                                                  Text(
                                                    "Camera",
                                                    style: category(),
                                                  )
                                                ],
                                              )),
                                          InkWell(
                                              onTap: () {
                                                selectImage();
                                              },
                                              child: Column(
                                                children: <Widget>[
                                                  Stack(
                                                    fit: StackFit.loose,
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                          "lib/assets/icon/blue.png"),
                                                      Icon(Icons.apps,
                                                          size: 22.0,
                                                          color: Colors.white),
                                                    ],
                                                  ),
                                                  Text(
                                                    "Gallery",
                                                    style: category(),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {},
                                            child: Column(
                                              children: <Widget>[
                                                Stack(
                                                  fit: StackFit.loose,
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: <Widget>[
                                                    Image.asset(
                                                        "lib/assets/icon/green.png"),
                                                    Icon(Icons.location_on,
                                                        size: 22.0,
                                                        color: Colors.white),
                                                  ],
                                                ),
                                                Text(
                                                  "Location",
                                                  style: category(),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                              onTap: getAudio,
                                              child: Column(
                                                children: <Widget>[
                                                  Stack(
                                                    fit: StackFit.loose,
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                          "lib/assets/icon/red.png"),
                                                      Icon(Icons.headset,
                                                          size: 22.0,
                                                          color: Colors.white),
                                                    ],
                                                  ),
                                                  Text(
                                                    "Music",
                                                    style: category(),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }),
                  IconButton(
                      icon: Icon(Icons.star),
                      color: starMark ? secondary : Colors.grey.shade400,
                      onPressed: () {
                        setState(() => starMark = !starMark);
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    color: primary,
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      'SAVE PRIOR TASKS',
                                      textAlign: TextAlign.center,
                                      style: categoryWhite(),
                                    )),
                              );
                            });
                      }),
                  IconButton(
                      icon: Icon(Icons.mic),
                      color: mic ? tertiary : Colors.grey.shade400,
                      onPressed: () {
                        setState(() => mic = !mic);
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(Recorder.tag);
                                },
                                child: Container(
                                    color: primary,
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      'ADD AUDIO CLIP',
                                      textAlign: TextAlign.center,
                                      style: categoryWhite(),
                                    )),
                              );
                            });
                      }),
                ],
              ),
              Divider(
                color: Colors.grey.shade500,
                height: 20.0,
              ),
              Container(
                padding: EdgeInsetsDirectional.only(start: 10.0),
                child: TextFormField(
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write here about your task',
                    hintStyle: hintStyleDark(),
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  style: subTitleBlack(),
                ),
              ),
              Divider(
                color: Colors.grey.shade500,
                height: 20.0,
              ),
              visibilityTag
                  ? new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsetsDirectional.only(start: 10.0),
                          child: TextFormField(
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add Task',
                              hintStyle: hintStyleDark(),
                            ),
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            style: subTitleBlack(),
                          ),
                        ),
                        visibilityObs
                            ? new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsetsDirectional.only(start: 10.0),
                                    child: TextFormField(
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Add Task',
                                        hintStyle: hintStyleDark(),
                                      ),
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      style: subTitleBlack(),
                                    ),
                                  ),
                                ],
                              )
                            : new Container(),
                        new RaisedButton(
                          child: new Text(
                            'Add More',
                            style: subTitleBlack(),
                          ),
                          elevation: 0.0,
                          color: Colors.grey.shade300,
                          onPressed: () {
                            visibilityObs ? null : _changed(true, "obs");
                          },
                        ),
                      ],
                    )
                  : new Container(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: new Container(
        color: secondary,
        child: new InkWell(
          onTap: () {},
          child: new Padding(
            padding: new EdgeInsets.all(15.0),
            child: new Text(
              "Add Task",
              style: categoryWhite(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class CompositeSubscription {
  Set<StreamSubscription> _subscriptions = new Set();

  void cancel() {
    for (var n in this._subscriptions) {
      n.cancel();
    }
    this._subscriptions = new Set();
  }

  void add(StreamSubscription subscription) {
    this._subscriptions.add(subscription);
  }

  void addAll(Iterable<StreamSubscription> subs) {
    _subscriptions.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return this._subscriptions.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return this._subscriptions.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return this._subscriptions.toList();
  }
}
