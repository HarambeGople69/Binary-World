import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetail extends ChangeNotifier {
  String name = "";
  String email = "";
  String password = "";
  String AddedOn = "";
  String imageUrl = "";
  Future<void> saveUserAuth() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var snapShotsValue = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("User Detail")
        .get();
    await _prefs.setString("email", snapShotsValue.docs[0].data()["email"]);
    await _prefs.setString(
        "password", snapShotsValue.docs[0].data()["password"]);
    await _prefs.setString("name", snapShotsValue.docs[0].data()["name"]);
    await _prefs.setString(
        "imageUrl", snapShotsValue.docs[0].data()["imageUrl"] ?? "");
    await _prefs.setString("AddedOn", snapShotsValue.docs[0].data()["AddedOn"]);

    print("Authentication done saved============");
  }

  removeUserAuth() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove("email");
    _prefs.remove("password");
    _prefs.remove("imageUrl");
    _prefs.remove("AddedOn");
    print("Sharedpreference data removed==========");
  }

  getUsername() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _username = _prefs.getString("name")!;
    name = _username;
    print("$name ==============name=============");
    notifyListeners();
  }

  Future<String> getEmail() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _email = _prefs.getString("email").toString();
    email = _email;
    notifyListeners();
    return _email;
  }

  Future<String> getPassword() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _password = _prefs.getString("password").toString();
    password = _password;
    notifyListeners();
    return _password;
  }

  Future<String> getImageUrl() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _imageUrl = _prefs.getString("imageUrl").toString();
    imageUrl = _imageUrl;
    notifyListeners();
    return _imageUrl;
  }

  Future<String> getAddedOn() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _AddedOn = _prefs.getString("AddedOn").toString();
    AddedOn = _AddedOn;
    notifyListeners();
    return _AddedOn;
  }
}
