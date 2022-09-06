// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Components/App%20Drawer/App_Drawer.dart';
import 'package:http/http.dart' as http;
import 'Crop_Scan.dart';
import 'package:hal_aur_ham_v2/Screens/Crop%20Scan/Choose_Crop.dart';

class ScanResult extends StatelessWidget {
  static const routeName = '/scanResultCopy';
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    var results = routeArgs['results'];
    final isLeaf = routeArgs['isLeaf'] as bool;
    final pickedImage = routeArgs['pickedImage'];

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
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: GlowContainer(
                            height: 340.h,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                              vertical: 2.h,
                              horizontal: 2.w,
                            ),
                            padding: EdgeInsets.only(
                                top: 17.h, left: 17.w, right: 17.w),
                            borderRadius: BorderRadius.circular(30.r),
                            color: Color(0xB0FFDFB0),
                            child: Column(
                              children: [
                                Container(
                                  child: isLeaf
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          child: Image.file(
                                            pickedImage,
                                            fit: BoxFit.fill,
                                            width: double.infinity,
                                            height: 300.h,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          child: Image.asset(
                                            'Assets/Images/OK.jpeg',
                                            fit: BoxFit.fill,
                                            width: double.infinity,
                                            height: 300.h,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: GlowContainer(
                            margin: EdgeInsets.symmetric(
                              vertical: 40.h,
                              horizontal: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(30.r),
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                            child: isLeaf == false
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                        width: double.infinity,
                                      ),
                                      Text(
                                        "No Leaf Detected",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(ChooseCrop.routeName);
                                        },
                                        child: Image.asset(
                                          'Assets/Images/camera.png',
                                          height: 60.h,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        "Scan Again",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      results == null
                                          ? Container(
                                              width: 82.w + 283.h,
                                              height: 150.h,
                                              child: Center(
                                                child: Text(
                                                  "Please Wait",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          : Column(
                                              children: [
                                                Text(
                                                  "Disease: ${results['top']}",
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Text(
                                                  "Confidence:  ${(results['confidence'] * 100).toStringAsFixed(2)}%",
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 70.w,
                                                    right: 70.w,
                                                  ),
                                                  child: ListTile(
                                                    title: Text(
                                                      "Video Link",
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color: Colors.white),
                                                    ),
                                                    trailing: Icon(
                                                      CupertinoIcons
                                                          .arrowtriangle_right_square,
                                                      size: 40.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 70.w, right: 70.w),
                                                  child: ListTile(
                                                    title: Text(
                                                      "Blog Link",
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    trailing: Icon(
                                                      Icons
                                                          .chrome_reader_mode_sharp,
                                                      size: 40.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                    ],
                                  ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
