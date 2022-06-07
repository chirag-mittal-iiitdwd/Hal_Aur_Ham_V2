// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, use_key_in_widget_constructors, unnecessary_new

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Components/App_Drawer.dart';
import 'package:hal_aur_ham_v2/Screens/Drone_Status.dart';
import 'package:hal_aur_ham_v2/Screens/Loading_Screen.dart';
import 'package:hal_aur_ham_v2/Screens/Scan_Result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

ImagePicker picker = ImagePicker();
var picked_image;
var isAnomaly;
var isLoading = false;

class CropScan extends StatefulWidget {
  static const routeName = '/cropScan';
  @override
  State<CropScan> createState() => _CropScanState();
}

class _CropScanState extends State<CropScan> {
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
                    margin: EdgeInsets.only(top: 70.h),
                    child: Column(
                      children: [
                        DemoVideo(),
                        Container(
                          height: 60.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.65),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 15.h),
                            child: Text(
                              "Check Out Previous Scans",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.6.h,
                            ),
                          ),
                        )
                      ],
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

class DemoVideo extends StatefulWidget {
  @override
  State<DemoVideo> createState() => _DemoVideoState();
}

class _DemoVideoState extends State<DemoVideo> {
  onUploadImage() async {
    setState(() {
      isLoading = true;
      Navigator.of(context).pushNamed(LoadingScreen.routeName);
    });
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://anomaly1291.herokuapp.com/predict/image"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        picked_image.readAsBytes().asStream(),
        picked_image.lengthSync(),
        filename: picked_image.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    setState(
      () {
        isLoading = false;
        isAnomaly = jsonDecode(response.body);
        Navigator.of(context).pushReplacementNamed(ScanResult.routeName);
      },
    );
  }

  Future openCamera() async {
    final camera_img = await picker.pickImage(
      source: ImageSource.camera,
    );
    picked_image = File(camera_img.path);
    if (picked_image != null) {
      onUploadImage();
    }
  }

  Future openGallery() async {
    final gallery_img = await picker.pickImage(
      source: ImageSource.gallery,
    );
    picked_image = File(gallery_img.path);
    if (picked_image != null) {
      onUploadImage();
    }
  }

  void UploadImageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          Column(
            children: [
              TextButton(
                onPressed: openGallery,
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Select Image From Gallery',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TextButton(
                onPressed: openCamera,
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Capture New Image',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Cancel',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

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
            Container(
              decoration: const BoxDecoration(color: Colors.black54),
              height: 300.h,
            ),
            IconButton(
              icon: Image.asset(
                'Assets/Images/ScanCamera.png',
              ),
              iconSize: 100.h,
              onPressed: UploadImageDialog,
            ),
          ],
        ),
      ),
    );
  }
}
