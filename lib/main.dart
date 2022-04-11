import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hal_aur_ham_v2/Model/ProfileModel.dart';
import 'package:provider/provider.dart';

import './Screens/Profile_Screen.dart';
import '../Model/Weather_Model.dart';
import '../Screens/Weather.dart';
import '../Screens/Login_Register.dart';
import './Screens/Login_Register.dart';
import './Model/NewsItems.dart';
import './Screens/WelcomeScreen.dart';

void main() {
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
          home: LoginRegister(),
          routes: {
            WelcomeScreen.routName: (ctx) => WelcomeScreen(),
            WeatherScreen.routeName: (ctx) => WeatherScreen(),
            Profile.routeName: (ctx) => Profile(),
            LoginRegister.routeName: (ctx) => LoginRegister(),
          },
        ),
      ),
      designSize: Size(375, 812),
    );
  }
}
