import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Screens/WeatherDetail.dart';

import '../Components/extraWeather.dart';
import '../Model/Weather_Model.dart';
import '../Components/App_Drawer.dart';

class WeatherScreen extends StatelessWidget {
  static const routeName = '/waether';
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
                  margin: EdgeInsets.only(top: 70.h),
                  child: Column(
                    children: [
                      CurrentWeather(),
                      TodayWeather(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TodayWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: Container(
          color: Colors.black54,
          padding: EdgeInsets.only(top: 10.h, left: 30.w, right: 30.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return WeatherDetail();
                          },
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          '7 Days',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                          size: 15.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WeatherWidget(todayWeather[0]),
                    WeatherWidget(todayWeather[1]),
                    WeatherWidget(todayWeather[2]),
                    WeatherWidget(todayWeather[3]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  WeatherWidget(this.weather);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: Colors.white),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        children: [
          Text(
            weather.current.toString() + '\u00B0',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Image(
            image: AssetImage(weather.image),
            height: 50.h,
            width: 50.w,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            weather.time,
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CurrentWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: GlowContainer(
        height: 450.h,
        margin: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: 2.w,
        ),
        padding: EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w),
        // glowColor: Color(0xB0FFDFB0),
        borderRadius: BorderRadius.circular(30.r),
        color: Color(0xB0FFDFB0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_pin),
                Text(
                  " " + currentTemp.location,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.w,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                "Updating",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Image(
              image: AssetImage(currentTemp.image),
              height: 100.h,
            ),
            SizedBox(height: 10.h),
            GlowText(
              currentTemp.current.toString(),
              style: TextStyle(
                height: 1.h,
                fontSize: 50.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              currentTemp.name,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
            Text(
              currentTemp.day,
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 6.h),
            Divider(
              color: Colors.black,
              height: 5.h,
            ),
            SizedBox(height: 6.h),
            ExtraWeather(currentTemp),
          ],
        ),
      ),
    );
  }
}
