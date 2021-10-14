import 'package:flutter/material.dart';
import 'package:myapp/Screens/pages/about_us.dart';
import 'package:myapp/Screens/pages/feed.dart';
import 'package:myapp/Screens/pages/notification.dart';
import 'package:myapp/Screens/pages/profile.dart';
import 'package:myapp/Screens/pages/rate_us.dart';
import 'package:myapp/Screens/pages/setting.dart';
import 'package:myapp/Screens/pages/wrapper_navigation.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final drawerController = ZoomDrawerController();
  int currentItem = 0;
  Widget getScreen() {
    switch (currentItem) {
      case 0:
        return Profile();
      case 1:
        return Feed();
      case 2:
        return Notifications();
      case 3:
        return AboutUs();
      case 4:
        return RateUs();
      case 5:
        return Setting();

      default:
        return Profile();
    }
  }

  @override
  Widget build(BuildContext context) => ZoomDrawer(
        // style: DrawerStyle.Style7,
        slideWidth: MediaQuery.of(context).size.width * 0.4,
        mainScreen: getScreen(),
        menuScreen: Builder(
          builder: (context) => WrpperNavigation(
            currentItem: currentItem,
            onSelectedItem: (item) {
              setState(() {
                currentItem = item;
                ZoomDrawer.of(context)!.close();
              });
            },
          ),
        ),
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      );
}
