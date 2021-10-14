import 'package:flutter/material.dart';
import 'package:myapp/widgets/menu_widget.dart';

class Feed extends StatefulWidget {
  const Feed({ Key? key }) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed page"),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Text("Feed Page"),
      ),
    );
  }
}