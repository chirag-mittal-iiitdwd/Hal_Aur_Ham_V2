// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Components/App_Drawer.dart';
import 'package:hal_aur_ham_v2/Screens/Scan_Result.dart';
import 'package:image_picker/image_picker.dart';

ImagePicker picker = ImagePicker();
var picked_image;

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

class DemoVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future openGallery() async {
      final gallery_img = await picker.pickImage(
        source: ImageSource.gallery,
      );
      picked_image = File(gallery_img.path);
      if (picked_image != null) {
        Navigator.of(context).pushReplacementNamed(ScanResult.routeName);
      }
    }

    Future openCamera() async {
      final camera_img = await picker.pickImage(
        source: ImageSource.camera,
      );
      picked_image = File(camera_img.path);
      if (picked_image != null) {
        Navigator.of(context).pushReplacementNamed(ScanResult.routeName);
      }
    }

    void _showErrorDialog() {
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
              onPressed: _showErrorDialog,
            ),
          ],
        ),
      ),
    );
  }
}
