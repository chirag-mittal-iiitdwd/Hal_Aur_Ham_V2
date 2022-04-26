import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Components/extraWeather.dart';
import 'package:hal_aur_ham_v2/Model/Weather_Model.dart';

class WeatherDetail extends StatelessWidget {
  final Weather tomorrowTemp;
  final List<Weather> sevenDay;
  WeatherDetail(this.tomorrowTemp, this.sevenDay);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Scaffold(
              body: Stack(
                children: [
                  Image.asset(
                    'Assets/Images/farm_back.jpg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Column(
                    children: [
                      TomorrowWeather(tomorrowTemp),
                      SizedBox(
                        height: 30.h,
                      ),
                      SevenDays(sevenDay),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
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

class TomorrowWeather extends StatelessWidget {
  final Weather tomorrowTemp;
  TomorrowWeather(this.tomorrowTemp);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GlowContainer(
        margin: EdgeInsets.only(top: 25.h),
        color: Color(0xB0FFDFB0),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 30.h,
                right: 30.w,
                left: 30.w,
                bottom: 20.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                      Text(
                        ' 7 Days',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              child: Row(
                children: [
                  Container(
                    width: 140.w,
                    height: 170.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(tomorrowTemp.image),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tomorrow',
                        style: TextStyle(fontSize: 20.sp, height: 1.h),
                      ),
                      Container(
                        height: 80.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GlowText(
                              tomorrowTemp.max.toString(),
                              style: TextStyle(
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '/ ' + tomorrowTemp.min.toString() + '\u00B0',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        " " + tomorrowTemp.name,
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 10.h,
                right: 25.w,
                left: 25.w,
              ),
              child: Column(
                children: [
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ExtraWeather(tomorrowTemp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  final List<Weather> sevenDay;
  SevenDays(this.sevenDay);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        // height: 325.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        color: Colors.black54,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
          ),
          itemCount: sevenDay.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                left: 25.w,
                right: 25.w,
                bottom: 14.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sevenDay[index].day,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                  Container(
                    width: 140.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(
                            sevenDay[index].image,
                          ),
                          width: 40.w,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          sevenDay[index].name,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "+" + sevenDay[index].max.toString() + "\u00B0",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "+" + sevenDay[index].min.toString() + "\u00B0",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
