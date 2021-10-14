import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OurListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function function;
  const OurListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: Text(
        title,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(17.5),
        ),
      ),
      leading: Icon(
        icon,
        size: ScreenUtil().setSp(27.5),
      ),
    );
  }
}
