import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Screens/Choose_Crop.dart';
import 'package:hal_aur_ham_v2/Screens/Community/Community_screen.dart';
import 'package:hal_aur_ham_v2/Screens/Crop_Scan.dart';
import 'package:hal_aur_ham_v2/Screens/Crop_Viz.dart';
import 'package:hal_aur_ham_v2/Screens/Drone_Status.dart';
import 'package:hal_aur_ham_v2/Screens/Login_Register.dart';
import 'package:hal_aur_ham_v2/Screens/Profile_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Screens/Weather/Weather.dart';
import '../Screens/WelcomeScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void logOut() async {
      await FirebaseAuth.instance.signOut();
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginRegister(),
        ),
      );
    }

    return Drawer(
      child: Stack(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: Text(
                    "Hal Aur Ham",
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 1.h),
                  margin: EdgeInsets.only(top: 10.h),
                  child: Image.asset('Assets/Images/App_Logo.png'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
                  title: Text(
                    'User Profile',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(Profile.routeName);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(WelcomeScreen.routName);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
                  title: Text(
                    'Weather',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Icon(
                    Icons.cloud,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(WeatherScreen.routeName);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
                  title: Text(
                    'Drone Status',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Icon(
                    Icons.airplanemode_active_sharp,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(DroneStatus.routeName);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
                  title: Text(
                    'Crop Viz',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Icon(
                    Icons.auto_graph,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(CropVizScreen.routeName);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
                  title: Text(
                    'Crop Scan',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Icon(
                    Icons.document_scanner_outlined,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(chooseCrop.routeName);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
                  title: Text(
                    'Community',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Icon(
                    Icons.people,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommunityScreen(),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginRegister.routeName);
                      },
                      child: GestureDetector(
                        onTap: logOut,
                        child: Row(
                          children: [
                            Text(
                              "Logout  ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                              ),
                            ),
                            Icon(
                              Icons.logout,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
