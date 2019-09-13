import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

fireStoreCommonService() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'test',
    options: const FirebaseOptions(
      googleAppID: '1:1065678221949:android:1756c86e7ac4d1a5',
      gcmSenderID: '1065678221949',
      apiKey: 'AIzaSyDcyCBNfAe7xWvfkC3dSQH1S640yfswQwg',
      projectID: 'todoapp-bce6f',
    ),
  );
  final Firestore firestore = Firestore(app: app);
  return firestore;
}
