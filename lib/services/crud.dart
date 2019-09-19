import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMedthods {

  FirebaseUser user;

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }


  Future<void> addData(taskData) async {
    if (isLoggedIn()) {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String  uid = user.uid;
      Firestore.instance.collection('docs$uid').add(taskData).catchError((e) {
        print(e);
      });
      //Using Transactions
//       Firestore.instance.runTransaction((Transaction crudTransaction) async {
//         CollectionReference reference =
//             await Firestore.instance.collection('docs$uid');
//
//         reference.add(taskData);
//       });
    } else {
      print('You need to be logged in');
    }
  }

  getData() async {
    if (isLoggedIn()) {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final uid = user.uid;
      return await Firestore.instance.collection('docs$uid').snapshots();
    } else {
      print('You need to be logged in');
    }
  }

  getTaskData(selectedDoc) async {
    if (isLoggedIn()) {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final uid = user.uid;
      return await Firestore.instance.collection('docs$uid').document(selectedDoc).snapshots();
    } else {
      print('You need to be logged in');
    }
  }


  updateData(selectedDoc, newValues)  async {
    if (isLoggedIn()) {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final uid = user.uid;
      Firestore.instance
          .collection('docs$uid')
          .document(selectedDoc)
          .updateData(newValues)
          .catchError((e) {
        print(e);
      });
    } else {
      print('You need to be logged in');
    }
  }


  deleteData(docId) async {
    if (isLoggedIn()) {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final uid = user.uid;
      Firestore.instance
          .collection('docs$uid')
          .document(docId)
          .delete()
          .catchError((e) {
        print(e);
      });
    } else {
      print('You need to be logged in');
    }

  }


  Future<void> contactUs(taskData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('contactus').add(taskData).catchError((e) {
        print(e);
      });
      //Using Transactions
//       Firestore.instance.runTransaction((Transaction crudTransaction) async {
//         CollectionReference reference =
//             await Firestore.instance.collection('docs$uid');
//
//         reference.add(taskData);
//       });
    } else {
      print('You need to be logged in');
    }
  }

}


