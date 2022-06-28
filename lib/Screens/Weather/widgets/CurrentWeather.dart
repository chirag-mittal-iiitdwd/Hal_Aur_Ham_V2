import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Model/Weather_Model.dart';
import './ExtraWeather.dart';
import '../Weather.dart';

class CurrentWeather extends StatefulWidget {
  final String city;
  Weather currentTemp;
  CurrentWeather({this.currentTemp, this.city});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.location_pin),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          widget.city,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    // Text(
                    //   " " + widget.city,
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20.sp,
                    //   ),
                    // ),
                    IconButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeatherScreen(),
                            ));
                      },
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),
              Image(
                image: AssetImage(widget.currentTemp.image),
                height: 100.h,
              ),
              SizedBox(height: 10.h),
              GlowText(
                widget.currentTemp.current.toString(),
                style: TextStyle(
                  height: 1.h,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.currentTemp.name,
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              Text(
                widget.currentTemp.day,
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
              ExtraWeather(temp: widget.currentTemp),
            ],
          ),
        ),
      ),
    );
  }
}
