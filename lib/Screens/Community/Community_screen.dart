import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Screens/Community/widgets/messages.dart';
import 'package:hal_aur_ham_v2/Screens/Community/widgets/new_message.dart';
import '../../Components/App_Drawer.dart';

class CommunityScreen extends StatelessWidget {
  static const routeName = '/community';
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
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 40.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 28.w),
                            child: Text(
                              'Community',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 32.sp,
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: Container(
                          //     child: Center(
                          //       child: Text(
                          //         'Currently this feature is under construction',
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30.h, left: 30.w, right: 30.w),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.h),
                              decoration: BoxDecoration(
                                color: Color(0xB0FFDFB0),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              height: 645.h,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Messages(),
                                  ),
                                  NewMessage(),
                                ],
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
          ],
        ),
      ),
    );
  }
}
