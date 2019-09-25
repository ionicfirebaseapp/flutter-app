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


  Future<void> addData(id,taskData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('docs$id').add(taskData).catchError((e) {
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

  getData(id) async {
    if (isLoggedIn()) {
      return await Firestore.instance.collection('docs$id').snapshots();
    } else {
      print('You need to be logged in');
    }
  }

  getTaskData(selectedDoc, id) async {
    if (isLoggedIn()) {
      return await Firestore.instance.collection('docs$id').document(selectedDoc).snapshots();
    } else {
      print('You need to be logged in');
    }
  }


  updateData(selectedDoc, id, newValues,)  async {
    if (isLoggedIn()) {
      Firestore.instance
          .collection('docs$id')
          .document(selectedDoc)
          .updateData(newValues)
          .catchError((e) {
        print(e);
      });
    } else {
      print('You need to be logged in');
    }
  }


  deleteData(docId, id) async {
    if (isLoggedIn()) {
      Firestore.instance
          .collection('docs$id')
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
    } else {
      print('You need to be logged in');
    }
  }

}


