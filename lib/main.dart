import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hal_aur_ham_v2/Screens/Crop%20Scan/Choose_Crop.dart';
import 'package:hal_aur_ham_v2/Screens/Community/Community_screen.dart';
import 'package:hal_aur_ham_v2/Screens/News%20Detail/News_Detail_Screen.dart';
import 'package:hal_aur_ham_v2/Screens/Crop%20Scan/Scan_Result.dart';
import 'package:hal_aur_ham_v2/Screens/Settings/SettingsScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './Screens/Settings/SettingsScreen.dart';
import 'Screens/Crop Scan/Crop_Scan.dart';
import 'Screens/Crop Viz/Crop_Viz.dart';
import 'Screens/Drone Status/Drone_Status.dart';
import 'Screens/Crop Scan/Scan_Result.dart';
import 'Screens/Profile/Profile_Screen.dart';
import '../Screens/Weather/Weather.dart';
import 'Screens/Auth/Login_Register.dart';
import './Model/NewsItems.dart';
import 'Screens/WelcomeScreen/WelcomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: NewsItems(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hal Aur Ham',
          theme: ThemeData(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            primarySwatch: Colors.blue,
            
          ),
          home: (FirebaseAuth.instance.currentUser != null)
              ? WelcomeScreen()
              : LoginRegister(),
          routes: {
            WelcomeScreen.routName: (ctx) => WelcomeScreen(),
            WeatherScreen.routeName: (ctx) => WeatherScreen(),
            Profile.routeName: (ctx) => Profile(),
            LoginRegister.routeName: (ctx) => LoginRegister(),
            DroneStatus.routeName: (ctx) => DroneStatus(),
            CropVizScreen.routeName: (ctx) => CropVizScreen(),
            CropScan.routeName: (ctx) => CropScan(),
            ScanResult.routeName: (ctx) => ScanResult(),
            NewsDetail.routeName: (ctx) => NewsDetail(),
            ChooseCrop.routeName: (ctx) => ChooseCrop(),
            SettingsScreen.routeName:(ctx)=>SettingsScreen(),
            CommunityScreen.routeName:(ctx)=>CommunityScreen(),
          },
        ),
      ),
      designSize: Size(375, 812),
    );
  }
}
