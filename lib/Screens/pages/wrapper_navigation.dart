import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Screens/pages/profile.dart';
import 'package:myapp/injection/appsharedpreference.dart';
import 'package:myapp/models/usermodel.dart';

import 'package:myapp/services/authentication/authentication.dart';
import 'package:myapp/widgets/our_list_tile.dart';
import 'package:myapp/widgets/our_sizebox.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WrpperNavigation extends StatefulWidget {
  final int currentItem;
  final ValueChanged<int> onSelectedItem;

  const WrpperNavigation({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);
  @override
  _WrpperNavigationState createState() => _WrpperNavigationState();
}

class _WrpperNavigationState extends State<WrpperNavigation> {
  String? username;
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedUsername = sharedPreferences.getString("name");
    setState(() {
      username = obtainedUsername;
    });

    print("$username Hii");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getName();
    getValidationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[100],
        body: Consumer<UserDetail>(builder: (context, userdetail, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: ScreenUtil().setSp(45),
                  ),
                  OurSizedHeight(),
                  Text(
                    username!,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(17.5),
                    ),
                  ),
                ],
              )),
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
