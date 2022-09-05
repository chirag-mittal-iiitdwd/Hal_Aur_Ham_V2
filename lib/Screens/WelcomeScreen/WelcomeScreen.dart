import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hal_aur_ham_v2/Screens/WelcomeScreen/Widgets/Button.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Components/App Drawer/App_Drawer.dart';
import 'package:hal_aur_ham_v2/Screens/WelcomeScreen/Widgets/NewsCarasoul.dart';
import 'package:hal_aur_ham_v2/Screens/Crop%20Scan/Choose_Crop.dart';
import 'package:hal_aur_ham_v2/Screens/Crop%20Viz/Crop_Viz.dart';
import 'package:hal_aur_ham_v2/Screens/Drone%20Status/Drone_Status.dart';
import 'package:hal_aur_ham_v2/Screens/Auth/Enter_user_details.dart';
import 'package:hal_aur_ham_v2/Screens/Weather/Weather.dart';

class WelcomeScreen extends StatefulWidget {
  static const routName = '/welcomeScreen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isloading = false;
  final curUser = FirebaseAuth.instance.currentUser;
  String userName = 'Loading...';

  void yourFunction(BuildContext context) async {
    setState(() {
      _isloading = true;
    });
    final uid = FirebaseAuth.instance.currentUser.uid;

    try {
      bool doWeHaveUserData = false;
      await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          if (element.id == uid) {
            doWeHaveUserData = true;
          }
        });
      });

      if (doWeHaveUserData == false) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegiserationForm(),
          ),
        );
      } else {
        final currentUserData =
            await FirebaseFirestore.instance.doc('users/' + curUser.uid).get();
        userName = currentUserData['name'];
      }

      setState(() {
        _isloading = false;
      });
    } on PlatformException catch (error) {
      print(error.message);
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => yourFunction(context));
  }

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
                  Image.asset(
                    'Assets/Images/farm_back.jpg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60.h),
                    child: _isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 28.w),
                                child: Text(
                                  'Welcome, ' + userName,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Button(
                                    routeName: WeatherScreen.routeName,
                                    imageRoute: 'Assets/Images/weather.png',
                                  ),
                                  Button(
                                    routeName: chooseCrop.routeName,
                                    imageRoute: 'Assets/Images/camera.png',
                                  ),
                                  Button(
                                    routeName: CropVizScreen.routeName,
                                    imageRoute: 'Assets/Images/graph.jpg',
                                  ),
                                  Button(
                                    routeName: DroneStatus.routeName,
                                    imageRoute: 'Assets/Images/drone.png',
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
