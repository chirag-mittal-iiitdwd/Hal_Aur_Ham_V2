import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final routeName;
  final String imageRoute;
  Button({this.routeName,this.imageRoute});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.r),
        child: Image.asset(
          imageRoute,
          height: 60.h,
        ),
      ),
    );
  }
}
