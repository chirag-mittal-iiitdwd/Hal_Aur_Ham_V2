import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
          },
        ),
      ),
      designSize: Size(375, 812),
    );
  }
}
