import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OurElevatedButton extends StatelessWidget {
  final Function function;
  final String title;

  const OurElevatedButton(
      {Key? key, required this.function, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
      child: SizedBox(
        width: double.infinity,
        height: ScreenUtil().setSp(45),
        child: ElevatedButton(
          onPressed: () {
            function();
          },
          child: Text(
            title,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(23),
            ),
          ),
        ),
      ),
    );
  }
}
