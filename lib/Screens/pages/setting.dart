import 'package:flutter/material.dart';
import 'package:myapp/widgets/menu_widget.dart';

class Setting extends StatefulWidget {
  const Setting({ Key? key }) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting page"),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Text("Setting Page"),
      ),
    );
  }
}