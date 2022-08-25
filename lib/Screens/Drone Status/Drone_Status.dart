import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Components/App Drawer/App_Drawer.dart';

class DroneStatus extends StatelessWidget {
  static const routeName = '/droneStatus';
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
                      top: 60.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 28.w),
                          child: Text(
                            'Drone Status',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 32.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 28.w),
                          child: Text(
                            'Location',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 28.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: Colors.blueAccent,
                          ),
                          height: 250.h,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 28.w),
                          height: 200.h,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            color: Color(0xa8FFDFB0),
                            child: Column(
                              children: [
                                DroneStatusConponents(
                                  title: 'Battery Status',
                                  itemValue: '93%',
                                ),
                                DroneStatusConponents(
                                  title: 'Connection',
                                  itemValue: '93%',
                                ),
                                DroneStatusConponents(
                                  title: 'Emergency Alerts',
                                  itemValue: 'None',
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15.h,
                                  horizontal: 10.w,
                                ),
                                primary: Color(0xD9FFDFB0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text(
                                    "Control Manually ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.sp,
                                    ),
                                  ),
                                  Icon(
                                    Icons.flight,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ],
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

class DroneStatusConponents extends StatelessWidget {
  final String title;
  final String itemValue;
  DroneStatusConponents({this.itemValue, this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              Icon(Icons.arrow_forward),
              Text(
                itemValue,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
