import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/services/compress%20image/compress_image.dart';
import 'package:myapp/widgets/custom_animated_alertdialog.dart';

class ProfileUpload {
  uploadProfile(
      File? file, String name, String bio, BuildContext context) async {
    AlertWidget().showLoading(context);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    String downloadUrl = "";
    try {
      if (file != null) {
        File compressedFile = await compressImage(file);

        final uploadFile = await firebaseStorage
            .ref("${FirebaseAuth.instance.currentUser!.uid}/profile_image")
            .putFile(compressedFile);

        if (uploadFile.state == TaskState.success) {
          downloadUrl = await firebaseStorage
              .ref("${FirebaseAuth.instance.currentUser!.uid}/profile_image")
              .getDownloadURL();
        }
        var list = await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("User Detail")
            .get();
        var a = list.docs[0].id;
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("User Detail")
            .doc(a)
            .update({"name": name, "bio": bio, "imageUrl": downloadUrl}).then(
                (value) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Profile Updated",
                style: TextStyle(fontSize: ScreenUtil().setSp(15)),
              ),
            ),
          );
          Navigator.pop(context);
        });
      } else {
        var list = await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("User Detail")
            .get();
        var a = list.docs[0].id;
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("User Detail")
            .doc(a)
            .update({
          "name": name,
          "bio": bio,
        }).then((value) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Profile Updated",
                style: TextStyle(fontSize: ScreenUtil().setSp(15)),
              ),
            ),
          );
          Navigator.pop(context);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Error occured",
            style: TextStyle(fontSize: ScreenUtil().setSp(15)),
          ),
        ),
      );
    }
  }
}
