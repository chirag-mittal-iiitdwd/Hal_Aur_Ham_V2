import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

class NewsDetail extends StatelessWidget {
  static const routeName = '/weatherDetail';
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    // print(routeArgs);
    final headline = routeArgs['headline'];
    final description = routeArgs['description'];
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset(
              'Assets/Images/farm_back.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            SingleChildScrollView(
              child: GlowContainer(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                color: Color(0xB0FFDFB0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 30.h,
                        right: 30.w,
                        left: 30.w,
                        bottom: 20.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 20.h,
                      ),
                      child: Text(
                        headline,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 20.h,
                      ),
                      child: Text(
                        description,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
