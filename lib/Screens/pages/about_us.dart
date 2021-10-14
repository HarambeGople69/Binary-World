import 'package:flutter/material.dart';
import 'package:myapp/widgets/menu_widget.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({ Key? key }) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text("About Us page"),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Text("About Us  Page"),
      ),
    );
  }
}