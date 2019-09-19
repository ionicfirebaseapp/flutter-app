import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_open/style/style.dart';
import 'package:todo_open/style/style.dart' as prefix0;
import '../../style/style.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:core';
import 'currentLocation.dart';
import '../../services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/attachmentIcon.dart';
import '../../screens/home/landing.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AddTask extends StatefulWidget {
  static String tag = "add-task";
  final bool update;
  final String updateDocId;
  AddTask({Key key, this.update, this.updateDocId}) : super(key: key);
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  String taskTitle, taskDetail, category;

  var tasks;

  crudMedthods crudObj = new crudMedthods();

  @override
  void initState() {
    getLocation();
    initializeNotifications();
    String id = widget.updateDocId;
    crudObj.getTaskData(id).then((results) {
      setState(() {
        tasks = results;
      });
    });
    super.initState();
  }

  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initializeNotifications() async {
    var initializeAndroid = AndroidInitializationSettings('ic_launcher');
    var initializeIOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(initializeAndroid, initializeIOS);
    await localNotificationsPlugin.initialize(initSettings);
  }

  TimeOfDay time = new TimeOfDay.now();
  TimeOfDay selectedTime = new TimeOfDay.now();

  DateTime now = new DateTime.now();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (picked != null && picked != time) {
      setState(() {
        selectedTime = picked;
      });
      print("selected time $selectedTime ");
    }
  }

  Future singleNotification(
      DateTime datetime, String message, String subtext, int hashcode,
      {String sound}) async {
    var androidChannel = AndroidNotificationDetails(
      'channel-id',
      'channel-name',
      'channel-description',
      importance: Importance.Max,
      priority: Priority.Max,
    );

    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    localNotificationsPlugin.schedule(
        hashcode, message, subtext, datetime, platformChannel,
        payload: hashcode.toString());
  }

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

  String dateNow = DateFormat('hh:mm aa - EEE d MMM').format(DateTime.now());

  final f = new DateFormat('yyyy-month-dd');
  DateTime _date = new DateTime.now();

  DateTime selectedDate;
  String dueDate;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2020),
    );
    if (picked != null && picked != _date) {
      setState(() {
        selectedDate = picked;
        dueDate = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
      print('Date selected: $dueDate');

    }
  }

  bool selectCategory = false;
  bool _value = false;
  onChanged(bool value) {
    setState(
      () {
        _value = value;
      },
    );
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

  static File _photoFile;
  static File _imageFile;

  takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      attach = true;
      _photoFile = image;
      count++;
    });
  }

  int count = 1;

  selectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      attach = true;
      _imageFile = image;
      count++;
    });
  }

  String _filePath;

  void getFilePath() async {
    String filePath = await FilePicker.getFilePath(type: FileType.ANY);
    if (filePath == '') {
      return;
    }
    setState(() {
      this._filePath = filePath;
    });
  }

  void getAudio() async {
    String filePath = await FilePicker.getFilePath(type: FileType.AUDIO);
    if (filePath == '') {
      return;
    }
    setState(() {
      this._filePath = filePath;
    });
  }

  var currentLocation = LocationData;
  var location = new Location();
  var lat, lng;

  getLocation() async {
    try {
      location.onLocationChanged().listen((LocationData currentLocation) {
        lat = currentLocation.latitude;
        lng = currentLocation.longitude;
        print('lattttttttttttttttt ${currentLocation.latitude}');
        print('loooongggggggggggggg ${currentLocation.longitude}');
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      }
      currentLocation = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    Widget _taskForm() {
      if (tasks != null) {
        return SingleChildScrollView(
          child: Container(
            child: StreamBuilder(
                stream: tasks,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Container(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: <Widget>[
                              Container(
                                padding: EdgeInsetsDirectional.only(start: 10.0),
                                child: TextFormField(
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Task Title',
                                    hintStyle: hintStyleDark(),
                                  ),
                                  initialValue: widget.update != null ? snapshot.data['taskTitle'] : "",
                                  keyboardType: TextInputType.text,
                                  style: titleStyleBoldLight(),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your Task Title';
                                    }
                                  },
                                  onSaved: (value) {
                                    this.taskTitle = value;
                                  },
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade500,
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsetsDirectional.only(start: 10.0),
                                child: TextFormField(
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Task Category',
                                    hintStyle: hintStyleDark(),
                                  ),
                                  initialValue: widget.update != null ? snapshot.data['category'] : "",
                                  keyboardType: TextInputType.text,
                                  style: titleStyleBoldLight(),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your Task Category';
                                    }
                                  },
                                  onSaved: (value) {
                                    this.category = value;
                                  },
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade500,
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 14.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    InkWell(
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset("lib/assets/icon/date.png"),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: Text("Add Date", style: smallAddressGreySR(),),
                                            )
                                          ],
                                        ),
//                        color: calender ? Colors.blueAccent : Colors.grey.shade400,
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return InkWell(
                                                  onTap: () {
                                                    setState(() => calender = true);
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
                                    InkWell(
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset("lib/assets/icon/notify.png"),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: Text("Notify me", style: smallAddressGreySR(),),
                                            )
                                          ],
                                        ),
//                          color: ring ? Colors.red : Colors.grey.shade400,
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 160.0,
                                                  child: ListView(
                                                    children: <Widget>[
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context).size.width,
                                                        color: primary,
                                                        padding: EdgeInsets.all(5.0),
                                                        child: MaterialButton(
                                                            onPressed: () async {
                                                              Navigator.pop(context);
                                                              setState(() => ring = true);
                                                              selectedDate == null ?
                                                              now = DateTime(
                                                                  now.year,
                                                                  now.month,
                                                                  now.day,
                                                                  selectedTime.hour,
                                                                  selectedTime.minute) :
                                                              now = DateTime(
                                                                  selectedDate.year,
                                                                  selectedDate.month,
                                                                  selectedDate.day,
                                                                  selectedTime.hour,
                                                                  selectedTime.minute);

                                                              print('alarm time $now');
//                                              await singleNotification(
//                                                now,
//                                                "Todod Notification on...",
//                                                "Looks like something intersting you have here...!!!",
//                                                98123871,
//                                              );
                                                            },
                                                            minWidth: MediaQuery.of(context)
                                                                .size
                                                                .width,
                                                            child: Text(
                                                              'ADD ALARM',
                                                              textAlign: TextAlign.center,
                                                              style: categoryWhite(),
                                                            )),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _selectDate(context);
                                                          });
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.all(15.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              dueDate == null
                                                                  ? Text(
                                                                '',
                                                                textAlign:
                                                                TextAlign.center,
                                                                style:
                                                                titleStyleBoldLight(),
                                                              )
                                                                  : Text(
                                                                '$dueDate',
                                                                textAlign:
                                                                TextAlign.center,
                                                                style:
                                                                titleStyleBoldLight(),
                                                              ),
                                                              Text(
                                                                'Set',
                                                                textAlign: TextAlign.center,
                                                                style: address(),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _selectTime(context);
                                                          });
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.all(15.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Text(
                                                                '${selectedTime.format(context)}',
                                                                textAlign: TextAlign.center,
                                                                style: titleStyleBoldLight(),
                                                              ),
                                                              Icon(Icons.keyboard_arrow_down),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        }),
                                    InkWell(
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset("lib/assets/icon/attach.png"),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: Text("Attach", style: smallAddressGreySR(),),
                                            )
                                          ],
                                        ),
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 160.0,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
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
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                    context) =>
                                                                        CurrentLocation(
                                                                          lat: lat,
                                                                          lng: lng,
                                                                        ),
                                                                  ),
                                                                );
                                                              },
                                                              child: AttachmentIcon(
                                                                title: "Location",
                                                                bg: "lib/assets/icon/green.png",
                                                                icon: Icon(
                                                                  Icons.location_on,
                                                                  size: 22.0,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: takeImage,
                                                              child: AttachmentIcon(
                                                                title: "Camera",
                                                                bg: "lib/assets/icon/orange.png",
                                                                icon: Icon(
                                                                  Icons.camera_alt,
                                                                  size: 22.0,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: selectImage,
                                                              child: AttachmentIcon(
                                                                title: "Gallery",
                                                                bg: "lib/assets/icon/blue.png",
                                                                icon: Icon(
                                                                  Icons.apps,
                                                                  size: 22.0,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        }),
                                    InkWell(
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset("lib/assets/icon/date.png"),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: Text("Priority", style: smallAddressGreySR(),),
                                            )
                                          ],
                                        ),
//                          color: starMark ? secondary : Colors.grey.shade400,
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return InkWell(
                                                  onTap: () {
                                                    setState(() => starMark = true);
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
                                  ],
                                ),
                              ),

                              Container(
                                padding: EdgeInsetsDirectional.only(start: 10.0),
                                child: TextFormField(
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Write here about your task',
                                    hintStyle: hintStyleDark(),
                                  ),
                                  initialValue: widget.update != null ? snapshot.data['taskDetail'] : "",
                                  keyboardType: TextInputType.text,
                                  maxLines: 5,
                                  style: subTitleBlack(),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your Task Detail';
                                    }
                                  },
                                  onSaved: (value) {
                                    this.taskDetail = value;
                                  },
                                ),
                              ),
                              _imageFile == null
                                  ? Container()
                                  : Container(
                                margin: EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.file(
                                      _imageFile,
                                      height: 100.0,
                                      width: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: darkGrey,
                                        size: 16.0,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _imageFile = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              _photoFile == null
                                  ? Container()
                                  : Container(
                                margin: EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.file(
                                      _photoFile,
                                      height: 100.0,
                                      width: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: darkGrey,
                                        size: 16.0,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _photoFile = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        );
      } else {
        return Container(
          child: CircularProgressIndicator(),
        );
      }
    }

    return Scaffold(
      key: _scaffoldkey,
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
      body: _taskForm(),
      bottomNavigationBar: new Container(
        color: secondary,
        child: new InkWell(
          onTap: () async {
            final FormState form = _formKey.currentState;
            if (!form.validate()) {

            } else {
              form.save();
              if (widget.update == true) {
                print('11111111 update task');
                try {
                  crudObj.updateData(widget.updateDocId, {
                    'taskTitle': this.taskTitle,
                    'taskDetail': this.taskDetail,
                    'priorityTask': starMark,
                    'notify': ring,
                    'dateTime': this.dateNow,
                    'dueDate': this.dueDate,
                    'category': this.category,
                    'completed': false,
                    'attach': this.attach,
                  });
                  uploadDocs();
                  _scaffoldkey.currentState.showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blueGrey,
                        content: Text('Task Updated successfully...!!!'),
                        duration: Duration(seconds: 1),
                      ));

                  new Future.delayed(const Duration(seconds: 1), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Landing(),
                      ),
                    );
                  });
                } catch (e) {
                  print(e);
                }
              } else {
                try {
                  print('11111111 add task $taskTitle');
                  crudObj.addData({
                    'taskTitle': this.taskTitle,
                    'taskDetail': this.taskDetail,
                    'priorityTask': starMark,
                    'notify': ring,
                    'dateTime': this.dateNow,
                    'dueDate': this.dueDate,
                    'category': this.category,
                    'completed': false,
                    'attach': this.attach,
                  });
                  uploadDocs();
                  _scaffoldkey.currentState.showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blueGrey,
                        content: Text('Task Added successfully...!!!'),
                        duration: Duration(seconds: 1),
                      ));

                  new Future.delayed(const Duration(seconds: 1), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Landing(),
                      ),
                    );
                  });

                } catch (e) {
                  print(e);
                }
              }
              ring == true ? await singleNotification(
                  now,
                  "Todo - $taskTitle",
                  "Looks like something intersting you have here...!!!",
                  98123871,
              ) : Container();
            }
          },
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

  uploadDocs() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid;
    if (_imageFile != null && _photoFile != null) {
      final StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('docs$uid/image$count.jpg');
      final StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
      final StorageReference firebaseStorageRef2 =
          FirebaseStorage.instance.ref().child('docs$uid/images$count.jpg');
      final StorageUploadTask task2 = firebaseStorageRef2.putFile(_photoFile);
    } else if (_imageFile == null && _photoFile == null) {
      return null;
    } else {
      if (_photoFile != null) {
        final StorageReference firebaseStorageRef2 =
            FirebaseStorage.instance.ref().child('docs$uid/images$count.jpg');
        final StorageUploadTask task2 = firebaseStorageRef2.putFile(_photoFile);
      } else {
        final StorageReference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('docs$uid/image$count.jpg');
        final StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
      }
    }
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
