import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Model/Weather_Model.dart';

class ExtraWeather extends StatelessWidget {
  final Weather temp;
  ExtraWeather({this.temp});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              CupertinoIcons.wind,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              temp.wind.toString() + ' Km/h',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              'Wind',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.drop,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              temp.humidity.toString() + ' %',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              'Humidity',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.cloud_rain,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              temp.chanceRain.toString() + ' %',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              'Rain',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
