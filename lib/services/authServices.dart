import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

 registerUser(email,password) {
    return _auth.createUserWithEmailAndPassword(email: email,password:password);
  }