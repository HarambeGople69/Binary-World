import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String name;
  final String AddedOn;
  final String imageUrl;
  final String bio;
  final String password;
  final String uid;

  UserModel({
    required this.email,
    required this.name,
    required this.AddedOn,
    required this.imageUrl,
    required this.bio,
    required this.password,
    required this.uid,
  });

  factory UserModel.fromJson(DocumentSnapshot querySnapshot) {
    return UserModel(
      email: querySnapshot["email"],
      name: querySnapshot["name"],
      AddedOn: querySnapshot["AddedOn"],
      imageUrl: querySnapshot["imageUrl"],
      bio: querySnapshot["bio"],
      password: querySnapshot["password"],
      uid: querySnapshot["uid"],
    );
  }
}
