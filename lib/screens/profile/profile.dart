import 'package:flutter/material.dart';
import 'package:todo_open/screens/priority_task/priority_task.dart';
import 'package:todo_open/screens/settings/contact_us.dart';
import 'package:todo_open/screens/task/task_list.dart';
import 'package:todo_open/style/style.dart' as prefix0;
import '../../style/style.dart';
import '../../screens/home/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class Profile extends StatefulWidget {
  static String tag = "profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  crudMedthods crudObj = new crudMedthods();

  @override
  void initState() {
    super.initState();
    userInfo();
  }

  var userName, email, uid;
  var photoUrl;
  bool imageLoading = false;
  var fbUser, fbEmail, fbProfile, fbId;
  var loginType;
  var twId, twUser;

  userInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginType = prefs.getString('loginType');
    });
    print("logintype ...................$loginType");
    if(loginType == 'fb'){
      setState(() {
        imageLoading = true;
        fbUser = prefs.getString('fbUser');
        fbEmail = prefs.getString('fbEmail');
        fbId = prefs.getString('fbId');
        fbProfile = prefs.getString('fbProfile');
      });
      print('fb user $fbUser $fbProfile, $fbEmail, $fbId');
    }else if(loginType == 'tw'){
      setState(() {
        twUser = prefs.getString('twUser');
        twId = prefs.getString('twId');
      });
      print('twuser $twUser $twId');
    }else if(loginType == 'fs') {
      FirebaseUser userProfile = await FirebaseAuth.instance.currentUser();
      if (userProfile != null) {
        setState(() {
          userName = userProfile.displayName;
          email = userProfile.email;
          uid = userProfile.uid;
          photoUrl = userProfile.photoUrl;
          imageLoading = false;
        });
      }
      print('photourl.................... $userName $photoUrl');
    }
  }

  var imageUrl;

  static File _imageFile;

  takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageLoading = true;
      _imageFile = image;
      print('Image Path $_imageFile');
    });
    print("TakeImage  $_imageFile");
    String fileName = path.basename(_imageFile.path);

    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
    print('pic $task');
    var taskSnapshot =
    await (await task.onComplete).ref.getDownloadURL();

    imageUrl = taskSnapshot.toString();
    FirebaseAuth.instance.currentUser().then((val) {
      UserUpdateInfo updateUser = UserUpdateInfo();
      updateUser.photoUrl = imageUrl;
      val.updateProfile(updateUser);
    });
    userInfo();
    setState(() {
      imageLoading = false;
    });
  }

  selectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageLoading = true;
      _imageFile = image;
    });
    print("SelectImage  $_imageFile");
    String fileName = path.basename(_imageFile.path);

    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
    var taskSnapshot =
    await (await task.onComplete).ref.getDownloadURL();

    imageUrl = taskSnapshot.toString();
    FirebaseAuth.instance.currentUser().then((val) {
      UserUpdateInfo updateUser = UserUpdateInfo();
      updateUser.photoUrl = imageUrl;
      val.updateProfile(updateUser);
    });
    userInfo();
    setState(() {
      imageLoading = false;
    });
    print('pic $imageUrl');
  }

  Widget profileImage() {
    return
    imageUrl != null ?
    ClipOval(child: Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover,)) :
    photoUrl != null ? ClipOval(child: Image.network(photoUrl, width: 100, height: 100, fit: BoxFit.cover,)):
    Image.asset("lib/assets/icon/user.png", width: 100, height: 100, color: Colors.white,);
//    new Image.asset(
//      'lib/assets/gif/load.gif',
//      color: Colors.white,
//      width: 22.0,
//      height: 22.0,
//    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: InkWell(
          onTap: () {
            takeImage();
            Navigator.of(context).pop(false);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.camera_alt, size: 18.0, color: Colors.black),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
              ),
              Text(
                "Select Camera",
                style: prefix0.address(),
              ),
            ],
          ),
        ),
        content: InkWell(
          onTap: () {
            selectImage();
            Navigator.of(context).pop(false);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.image, size: 18.0, color: Colors.black),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
              ),
              Text("Select Gallery", style: prefix0.address()),
            ],
          ),
        ),
      ),
    ) ??
        false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefix0.bgGrey,
      drawer: DrawerList(),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Profile", style: subBoldTitleWhite(),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Container(
            height: 120.0,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: primary.withOpacity(0.4),
                  child: loginType == 'fb' ?
                    ClipOval(child: Image.network(fbProfile, width: 100, height: 100, fit: BoxFit.cover,)) :
                    profileImage(),
                ),
                loginType == 'fs' ? Positioned(
                  right: prefix0.screenWidth(context)/3.4,
                  top: prefix0.screenHeight(context)/9,
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    child: new FloatingActionButton(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      onPressed: () => _onWillPop(),
                      tooltip: 'Photo',
                      child: new Icon(Icons.camera_alt, size: 14.0,),
                    ),
                  ),
                ) : Container(),
              ],
            ),
          ),
          Container(
            height: 70.0,
            margin: EdgeInsets.only(top: 20.0, bottom: 14.0),
            width: screenHeight(context),
            padding: EdgeInsets.all(14.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () => _onWillPop(),
                  child: CircleAvatar(
                    radius: 22.0,
                    backgroundColor: primary.withOpacity(0.4),
                    child: loginType == 'fb' ?
                    ClipOval(child: Image.network(fbProfile, width: 100, height: 100, fit: BoxFit.cover,)) :
                    profileImage(),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        loginType == 'fs' ? Text('$userName', style: textStyleOrangeSS(),) :
                          loginType == 'fb' ?  Text('$fbUser', style: textStyleOrangeSS(),) :
                            Text('$twUser', style: textStyleOrangeSS(),),
                        loginType == 'fs' ? Text('$email', style: smallBoldDescription(),) :
//                          loginType == 'fb' && fbEmail != null ? Text('$fbEmail', style: smallBoldDescription(),) :
                            Text('', style: smallBoldDescription(),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(PriorityTask.tag);
            },
            child: Container(
              height: 70.0,
              width: screenHeight(context),
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(bottom: 14.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(icon: Image.asset("lib/assets/icon/timeline.png", height: 22.0, width: 22.0,)),
                      Text("Priority Tasks", style: textSmallStyleGreySS(),),
                    ],
                  ),
                  IconButton(icon: Image.asset("lib/assets/icon/arrow.png", height: 22.0, width: 22.0,)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(TaskList.tag);
            },
            child: Container(
              height: 70.0,
              width: screenHeight(context),
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(bottom: 14.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(icon: Image.asset("lib/assets/icon/completed.png", height: 22.0, width: 22.0, color: Colors.black,)),
                      Text("Task List", style: textSmallStyleGreySS(),),
                    ],
                  ),
                  IconButton(icon: Image.asset("lib/assets/icon/arrow.png", height: 22.0, width: 22.0,)),
                ],
              ),
            ),
          ),
//          InkWell(
//            onTap: (){
//              Navigator.of(context).pushNamed(ContactUs.tag);
//            },
//            child: Container(
//              height: 70.0,
//              width: screenHeight(context),
//              padding: EdgeInsets.all(8.0),
//              margin: EdgeInsets.only(bottom: 14.0),
//              decoration: new BoxDecoration(
//                color: Colors.white,
//                boxShadow: [
//                  new BoxShadow(
//                    color: Colors.grey.shade300,
//                    blurRadius: 8.0,
//                  ),
//                ],
//              ),
//              child: Row(
//                children: <Widget>[
//                  IconButton(icon: Image.asset("lib/assets/icon/help.png", height: 22.0, width: 22.0, color: Colors.black,)),
//                  Text("Help", style: textSmallStyleGreySS(),),
//                ],
//              ),
//            ),
//          ),
        ],
      )
    );
  }
}
