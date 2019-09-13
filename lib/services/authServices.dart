import '../common/constant.dart';
import 'dart:async';
import 'dart:convert';

class LoginService {
  static Future<Map<String, dynamic>> registerUser(
      email, password, name) async {
    final response = await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userNew) {
      databaseReference
          .collection("users")
          .document(userNew.uid)
          .setData({'email': email, 'name': name});
    });
    print('ressss ${json.decode(response)}');
    return json.decode(response);
  }

  static Future<Map<String, dynamic>> loginUser(email, password) async {
    final response = await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((onValue) {});
    print('loggggggggg ${json.decode(response)}');
    return json.decode(response);
  }
}
