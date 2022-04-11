import 'package:flutter/material.dart';
import 'package:hal_aur_ham_v2/Screens/Weather.dart';
import 'package:intl/intl.dart';
import 'package:hal_aur_ham_v2/Components/NewsCarasoul.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Components/App_Drawer.dart';

class WelcomeScreen extends StatelessWidget {
  static const routName = '/welcomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Image.asset(
                  'Assets/Images/farm_back.jpg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
                Container(
                  margin: EdgeInsets.only(top: 85.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 28.w),
                        child: Text(
                          'Welcome, User',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 32.sp,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 28.w),
                        child: Text(
                          DateFormat.yMMMd().format(DateTime.now()),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 20.h,
                        ),
                        child: NewsCarasoul(),
                      ),
                      SizedBox(
                        height: 230.h,
                      ),
                      GridTileBar(
                        backgroundColor: Colors.black87,
                        title: Text(
                          'What Would You Like To Do',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22.sp),
                        ),
                      ),
                      SizedBox(height: 46.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                  WeatherScreen.routeName);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.asset(
                                'Assets/Images/weather.png',
                                height: 60.h,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Image.asset(
                              'Assets/Images/camera.png',
                              height: 60.h,
                            ),
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.asset(
                                'Assets/Images/graph.jpg',
                                height: 60.h,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Image.asset(
                              'Assets/Images/drone.png',
                              height: 60.h,
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
    );
  }
}
