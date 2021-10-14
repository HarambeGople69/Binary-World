import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Firestore {
  addUser(String uid, String email, String password, String name) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .collection("User Detail")
          .add({
        "email": email,
        "password": password,
        "AddedOn": DateFormat('yyy-MM--dd').format(
          DateTime.now(),
        ),
        "imageUrl": "",
        "name": name,
      }).then((value) => print("DOne============="));
    } catch (e) {
      print(e);
    }
  }
}
