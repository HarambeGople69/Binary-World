import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/injection/appsharedpreference.dart';
import 'package:myapp/models/usermodel.dart';

import 'package:myapp/services/authentication/authentication.dart';
import 'package:myapp/widgets/our_list_tile.dart';
import 'package:myapp/widgets/our_sizebox.dart';
import 'package:provider/provider.dart';

class WrpperNavigation extends StatefulWidget {
  final int currentItem;
  final ValueChanged<int> onSelectedItem;
  final UserModel userModel;

  const WrpperNavigation({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
    required this.userModel,
  }) : super(key: key);
  @override
  _WrpperNavigationState createState() => _WrpperNavigationState();
}

class _WrpperNavigationState extends State<WrpperNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[100],
        body: Consumer<UserDetail>(builder: (context, userdetail, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("User Detail")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.length > 0) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                UserModel userModel = UserModel.fromJson(
                                    snapshot.data!.docs[index]);
                                return DrawerHeader(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    userModel.imageUrl == ""
                                        ? CircleAvatar(
                                            radius: ScreenUtil().setSp(35),
                                            child: Text(userModel.name[0],
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(30),
                                                )),
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              ScreenUtil().setSp(50),
                                            ),
                                            child: Image.network(
                                              userModel.imageUrl,
                                              height: ScreenUtil().setSp(80),
                                              width: ScreenUtil().setSp(80),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                    OurSizedHeight(),
                                    Text(
                                      userModel.name,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(17.5),
                                      ),
                                    ),
                                  ],
                                ));
                              });
                        }
                      }
                      return CircularProgressIndicator();
                    }),
              ),
              OurListTile(
                function: () {
                  widget.onSelectedItem(0);
                },
                title: "Profile",
                icon: Icons.person,
              ),
              OurListTile(
                function: () {
                  widget.onSelectedItem(1);
                },
                title: "Feed",
                icon: Icons.feed,
              ),
              OurListTile(
                function: () {
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //     return Notifications();
                  //   }));
                  widget.onSelectedItem(2);
                },
                title: "Notification",
                icon: Icons.notifications,
              ),
              OurListTile(
                function: () {
                  widget.onSelectedItem(3);
                },
                title: "About Us",
                icon: Icons.info_outline,
              ),
              OurListTile(
                function: () {
                  widget.onSelectedItem(4);
                },
                title: "Rate Us",
                icon: Icons.star_border,
              ),
              OurListTile(
                function: () {
                  widget.onSelectedItem(5);
                },
                title: "Setting",
                icon: Icons.settings,
              ),
              OurListTile(
                function: () {
                  Auth().logout(context);
                  // saveUserAuth();
                },
                title: "Logout",
                icon: Icons.logout,
              ),
            ],
          );
        }));
  }
}
