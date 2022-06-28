import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Screens/Weather/widgets/WeatherDetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

import '../Components/extraWeather.dart';
import '../Model/Weather_Model.dart';
import '../Components/App_Drawer.dart';

Weather currentTemp;
Weather tomorrowTemp;

List<Weather> todayWeather;
List<Weather> sevenDay;
// String lat = '53.9006';
// String lon = '27.5590';
// String city = "Minisk";

class WeatherScreen extends StatefulWidget {
  static const routeName = '/waether';

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String lat;
  String lon;
  String city;

  getData() async {
    try {
      fetchData(lat, lon, city).then((value) {
        currentTemp = value[0];
        todayWeather = value[1];
        tomorrowTemp = value[2];
        sevenDay = value[3];
        setState(() {});
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff030317),
            title: Text('Some Error Occured'),
            // content: Text("Please check the city name"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"))
            ],
          );
        },
      );
    }
  }

  void yourFunction(BuildContext context) async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final currentUserData =
        await FirebaseFirestore.instance.doc('users/' + uid).get();

    lat = currentUserData['latitude'].toString();
    lon = currentUserData['longitude'].toString();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(double.parse(lat), double.parse(lon));
    print(lat);
    print(lon);
    print(placemarks[0]);
    city = placemarks[0].subLocality + ", " + placemarks[0].locality;
    setState(() {});
    getData();
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
                    margin: EdgeInsets.only(top: 40.h),
                    child: currentTemp == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                CurrentWeather(lat, lon, city),
                                TodayWeather(),
                              ],
                            ),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
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

class CurrentWeather extends StatefulWidget {
  // final Function() updateData;
  String lat;
  String lon;
  String city;
  CurrentWeather(this.lat, this.lon, this.city);
  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  bool searchBar = false;
  bool updating = false;
  var focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchBar) {
          setState(() {
            searchBar = false;
          });
        }
      },
      child: Container(
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
                  child: searchBar
                      ? TextField(
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter a city Name",
                          ),
                          textInputAction: TextInputAction.search,
                          // onSubmitted: (value) async {
                          //   CityModel temp = await (fetchCity(value));
                          //   if (temp == null) {
                          //     showDialog(
                          //       context: context,
                          //       builder: (BuildContext context) {
                          //         return AlertDialog(
                          //           backgroundColor: Color(0xff030317),
                          //           title: Text('City not found'),
                          //           content: Text("Please check the city name"),
                          //           actions: [
                          //             TextButton(
                          //                 onPressed: () {
                          //                   Navigator.of(context).pop();
                          //                 },
                          //                 child: Text("Ok"))
                          //           ],
                          //         );
                          //       },
                          //     );
                          //     searchBar = false;
                          //     return;
                          //   }
                          //   widget.city = temp.name;
                          //   widget.lat = temp.lat;
                          //   widget.lon = temp.lon;
                          //   updating = true;
                          //   setState(() {});
                          //   widget.updateData();
                          //   searchBar = false;
                          //   updating = false;
                          //   setState(() {});
                          // },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_pin),
                            GestureDetector(
                              onTap: () {
                                searchBar = true;
                                setState(() {});
                                focusNode.requestFocus();
                              },
                              child: Text(
                                " " + widget.city,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.w,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    updating ? "Updating" : "Updated",
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
        ),
      ),
    );
  }
}
