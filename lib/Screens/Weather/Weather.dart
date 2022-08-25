import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hal_aur_ham_v2/Components/App%20Drawer/App_Drawer.dart';
import 'package:hal_aur_ham_v2/Model/Weather_Model.dart';
import '../../Model/Weather_Model.dart';
import './widgets/CurrentWeather.dart';
import './widgets/TodayWeather.dart';

class WeatherScreen extends StatefulWidget {
  static const routeName = '/weather';
  Weather currentTemp;
  Weather tomorrowTemp;
  List<Weather> todayWeather;
  List<Weather> sevenDay;
  String lat = '53.9006';
  String lon = '27.5590';
  String city = "Minisk";

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  void getData() async {
    try {
      fetchData(widget.lat, widget.lon, widget.city).then((value) {
        widget.currentTemp = value[0];
        widget.todayWeather = value[1];
        widget.tomorrowTemp = value[2];
        widget.sevenDay = value[3];
        setState(() {});
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff030317),
            title: const Text('Some Error Occured'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
              )
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

    widget.lat = currentUserData['latitude'].toString();
    widget.lon = currentUserData['longitude'].toString();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(widget.lat), double.parse(widget.lon));
    widget.city = placemarks[0].subLocality + ", " + placemarks[0].locality;
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
                    child: widget.currentTemp == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                CurrentWeather(
                                  city: widget.city,
                                  currentTemp: widget.currentTemp,
                                ),
                                TodayWeather(
                                  todayWeather: widget.todayWeather,
                                  sevenDay: widget.sevenDay,
                                  tomorrowTemp: widget.tomorrowTemp,
                                ),
                              ],
                            ),
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
