import 'package:flutter/material.dart';
import 'package:myapp/widgets/menu_widget.dart';

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
      ),
      body: Center(
        child: Text("profile Page"),
      ),
    );
  }
}
