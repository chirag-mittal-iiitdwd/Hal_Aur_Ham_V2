import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Components/App%20Drawer/Widgets/AppDrawerElement.dart';
import 'package:hal_aur_ham_v2/Components/LogoutButton.dart';
import 'package:hal_aur_ham_v2/Screens/Choose_Crop.dart';
import 'package:hal_aur_ham_v2/Screens/Community/Community_screen.dart';
import 'package:hal_aur_ham_v2/Screens/Crop_Scan.dart';
import 'package:hal_aur_ham_v2/Screens/Crop_Viz.dart';
import 'package:hal_aur_ham_v2/Screens/Drone_Status.dart';
import 'package:hal_aur_ham_v2/Screens/Auth/Login_Register.dart';
import 'package:hal_aur_ham_v2/Screens/Profile_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hal_aur_ham_v2/Screens/Settings/SettingsScreen.dart';

import '../../Screens/Weather/Weather.dart';
import '../../Screens/WelcomeScreen/WelcomeScreen.dart';

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
                AppDrawerElement(routeName: Profile.routeName, icon: Icons.supervised_user_circle, label: 'User Profile'),
                AppDrawerElement(routeName: WelcomeScreen.routName, icon: Icons.home, label: "Home"),
                AppDrawerElement(routeName: WeatherScreen.routeName, icon: Icons.cloud, label: 'Weather'),
                AppDrawerElement(routeName: DroneStatus.routeName, icon: Icons.cloud, label: 'Drone Status'),
                AppDrawerElement(routeName: CropVizScreen.routeName, icon: Icons.auto_graph, label: 'Crop Viz'),
                AppDrawerElement(routeName: chooseCrop.routeName, icon: Icons.document_scanner_outlined, label: 'Crop Scan'),
                AppDrawerElement(routeName: CommunityScreen.routeName, icon: Icons.people, label: 'Community'),
                AppDrawerElement(routeName: SettingsScreen.routeName, icon: Icons.settings, label: 'Settings'),
                
                LogoutButton(Buttontext: 'Logout'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
