import 'package:flutter/material.dart';
import 'package:myapp/widgets/menu_widget.dart';

class Notifications extends StatefulWidget {
  const Notifications({ Key? key }) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification page"),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Text("Notification Page"),
      ),
    );
  }
}