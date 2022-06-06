import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hal_aur_ham_v2/Screens/News_Detail_Screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './Model/ProfileModel.dart';
import './Screens/Crop_Scan.dart';
import './Screens/Crop_Viz.dart';
import './Screens/Drone_Status.dart';
import './Screens/Scan_Result.dart';
import './Screens/Profile_Screen.dart';
import '../Model/Weather_Model.dart';
import '../Screens/Weather.dart';
import '../Screens/Login_Register.dart';
import './Screens/Login_Register.dart';
import './Model/NewsItems.dart';
import './Screens/WelcomeScreen.dart';

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
          ChangeNotifierProvider.value(
            value: UserProfile(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hal Aur Ham',
          theme: ThemeData(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            primarySwatch: Colors.blue,
          ),
          home: (FirebaseAuth.instance.currentUser != null) ? WelcomeScreen() : LoginRegister(),
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
          },
        ),
      ),
      designSize: Size(375, 812),
    );
  }
}
