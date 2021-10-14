import 'package:flutter/material.dart';
import 'package:myapp/widgets/menu_widget.dart';

class RateUs extends StatefulWidget {
  const RateUs({ Key? key }) : super(key: key);

  @override
  _RateUsState createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Us page"),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Text("Rate Us Page"),
      ),
    );
  }
}