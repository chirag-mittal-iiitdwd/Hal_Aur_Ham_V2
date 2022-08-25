// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Components/App%20Drawer/App_Drawer.dart';
import 'package:http/http.dart' as http;
import 'Crop_Scan.dart';
import 'package:tflite/tflite.dart';
import 'package:hal_aur_ham_v2/Screens/Choose_Crop.dart';
import 'Loading_Screen.dart';

class ScanResult extends StatefulWidget {
  static const routeName = '/scanResult';

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  var results;
  AppleModel() async {
    await Tflite.loadModel(
      model: 'Assets/models/Apple.tflite',
      labels: 'Assets/models/Apple_labels.txt',
    );
  }

  MaizeModel() async {
    await Tflite.loadModel(
      model: 'Assets/models/Maize.tflite',
      labels: 'Assets/models/Maize_labels.txt',
    );
  }

  result(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 5, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );
    setState(() {
      results = recognitions;
    });
  }

  @override
  void initState() {
    super.initState();
    if (isLeaf) {
      if (selected_crop == 'Apple')
        AppleModel();
      else if (selected_crop == 'Maize') MaizeModel();
      result(picked_image);
    }
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
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: GlowContainer(
                              height: 355.h,
                              margin: EdgeInsets.symmetric(
                                vertical: 2.h,
                                horizontal: 2.w,
                              ),
                              padding: EdgeInsets.only(
                                  top: 30.h, left: 30.w, right: 30.w),
                              borderRadius: BorderRadius.circular(30.r),
                              color: Color(0xB0FFDFB0),
                              child: Column(children: [
                                Container(
                                  height: 283.h,
                                  width: 283.h,
                                  child: isLeaf == true
                                      ? Image.file(
                                          picked_image,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          'Assets/Images/OK.jpeg',
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ])),
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
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(chooseCrop.routeName);
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
                                          : results[0]["label"] != 'Other'
                                              ? Column(
                                                  children: [
                                                    Text(
                                                      "Disease: ${results[0]["label"]}",
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
                                                      results != null
                                                          ? "Confidence:  ${(results[0]["confidence"] * 100).toStringAsFixed(2)}%"
                                                          : "Loading...",
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
                                                              color:
                                                                  Colors.white),
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
                                                          left: 70.w,
                                                          right: 70.w),
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
                                              : Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 20.h,
                                                      width: double.infinity,
                                                    ),
                                                    Text(
                                                      "Leaf Detected",
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                chooseCrop
                                                                    .routeName);
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
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
