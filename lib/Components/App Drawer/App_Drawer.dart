import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Components/App%20Drawer/Widgets/AppDrawerElement.dart';
import 'package:hal_aur_ham_v2/Components/LogoutButton.dart';
import 'package:hal_aur_ham_v2/Screens/Crop%20Scan/Choose_Crop.dart';
import 'package:hal_aur_ham_v2/Screens/Community/Community_screen.dart';
import 'package:hal_aur_ham_v2/Screens/Crop%20Viz/Crop_Viz.dart';
import 'package:hal_aur_ham_v2/Screens/Drone%20Status/Drone_Status.dart';
import 'package:hal_aur_ham_v2/Screens/Profile/Profile_Screen.dart';
import 'package:hal_aur_ham_v2/Screens/Settings/SettingsScreen.dart';

import '../../Screens/Weather/Weather.dart';
import '../../Screens/WelcomeScreen/WelcomeScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
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
                const AppDrawerElement(routeName: Profile.routeName, icon: Icons.supervised_user_circle, label: 'User Profile'),
                const AppDrawerElement(routeName: WelcomeScreen.routName, icon: Icons.home, label: "Home"),
                const AppDrawerElement(routeName: WeatherScreen.routeName, icon: Icons.cloud, label: 'Weather'),
                const AppDrawerElement(routeName: DroneStatus.routeName, icon: Icons.flight, label: 'Drone Status'),
                const AppDrawerElement(routeName: CropVizScreen.routeName, icon: Icons.auto_graph, label: 'Crop Viz'),
                const AppDrawerElement(routeName: ChooseCrop.routeName, icon: Icons.document_scanner_outlined, label: 'Crop Scan'),
                const AppDrawerElement(routeName: CommunityScreen.routeName, icon: Icons.people, label: 'Community'),
                const AppDrawerElement(routeName: SettingsScreen.routeName, icon: Icons.settings, label: 'Settings'),
                
                LogoutButton(Buttontext: 'Logout'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
