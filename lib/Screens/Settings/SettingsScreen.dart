import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Components/App Drawer/App_Drawer.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              drawer: AppDrawer(),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.yellow,
                          Colors.orange,
                          Colors.green,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 40.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 28.w),
                          child: Text(
                            'Settings',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 32.sp,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Text(
                                'Currently this feature is under construction',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
