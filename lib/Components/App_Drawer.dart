import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 80.w),
            margin: EdgeInsets.only(top: 10.h),
            child: Image.asset('Assets/Images/App_Logo.png'),
          ),
        ],
      ),
    );
  }
}
