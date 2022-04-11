// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
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

    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Color(0xFFF5FFF9),
      appBar: AppBar(
        title: const Text(
          'Hal Aur Ham',
          textScaleFactor: 1.30,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.black54),
                height: MediaQuery.of(context).size.height * 0.32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFBAD7C7),
                    borderRadius: BorderRadius.circular(20)),
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: openCamera,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 70,
                      ),
                    ),
                    Text("Take Photo"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "OR",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: openGallery,
              child: Text(
                "Select Image From Gallery",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
