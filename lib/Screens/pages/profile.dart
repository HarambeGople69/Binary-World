import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Screens/pages/edit_profile_page.dart';
import 'package:myapp/models/usermodel.dart';
import 'package:myapp/widgets/custom_outline_button.dart';
import 'package:myapp/widgets/menu_widget.dart';
import 'package:myapp/widgets/our_followers_column.dart';
import 'package:myapp/widgets/our_sizebox.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile page"),
          leading: MenuWidget(),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(20),
              vertical: ScreenUtil().setSp(20),
            ),
            child: SingleChildScrollView(
              child: Column(
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
                              // return Text("AA");
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    UserModel userModel = UserModel.fromJson(
                                        snapshot.data!.docs[index]);
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            userModel.imageUrl == ""
                                                ? CircleAvatar(
                                                    radius:
                                                        ScreenUtil().setSp(35),
                                                    child: Text(
                                                        userModel.name[0],
                                                        style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(30),
                                                        )),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      ScreenUtil().setSp(50),
                                                    ),
                                                    child: Image.network(
                                                      userModel.imageUrl,
                                                      height: ScreenUtil()
                                                          .setSp(80),
                                                      width: ScreenUtil()
                                                          .setSp(80),
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: ScreenUtil().setSp(25),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      OurFollowersColumn(
                                                        number: 0,
                                                        title: "Post",
                                                      ),
                                                      OurFollowersColumn(
                                                        number: 0,
                                                        title: "Following",
                                                      ),
                                                      OurFollowersColumn(
                                                        number: 0,
                                                        title: "Followers",
                                                      ),
                                                    ],
                                                  ),
                                                  OurOutlineButton(
                                                      title: "Edit Profile",
                                                      function: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                fullscreenDialog:
                                                                    true,
                                                                builder:
                                                                    (context) {
                                                                  return EditPage(
                                                                      userModel:
                                                                          userModel);
                                                                }));
                                                      })
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        OurSizedHeight(),
                                        Column(
                                          children: [
                                            Text(
                                              userModel.name,
                                              style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(17.5),
                                              ),
                                            ),
                                            Text(
                                              userModel.bio,
                                              style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(17.5),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            }
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
