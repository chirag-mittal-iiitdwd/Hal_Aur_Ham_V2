import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Model/Weather_Model.dart';
import './WeatherDetail.dart';

class TodayWeather extends StatelessWidget {
  final List<Weather> todayWeather;
  final List<Weather> sevenDay;
  final Weather tomorrowTemp;
  TodayWeather({this.todayWeather,this.sevenDay,this.tomorrowTemp});
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
                            return WeatherDetail(tomorrowTemp, sevenDay);
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
