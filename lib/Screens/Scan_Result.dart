// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hal_aur_ham_v2/Components/App_Drawer.dart';
import 'Crop_Scan.dart';
import 'package:tflite/tflite.dart';

class ScanResult extends StatefulWidget {
  static const routeName = '/scanResult';

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  var results;
  loadModel() async {
    await Tflite.loadModel(
      model: 'Assets/models/myModel.tflite',
      labels: 'Assets/models/label.txt',
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
    loadModel();
    result(picked_image);
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.47,
                child: Image.file(
                  picked_image,
                  fit: BoxFit.fill,
                )),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  results != null
                      ? "Disease: ${results[0]["label"]}"
                      : "Loading...",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  results != null
                      ? "Confidence:  ${(results[0]["confidence"] * 100).toStringAsFixed(2)}%"
                      : "Loading...",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 70,
                    right: 70,
                  ),
                  child: ListTile(
                    title: Text(
                      "Video Link",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(
                      CupertinoIcons.arrowtriangle_right_square,
                      size: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0, right: 70),
                  child: ListTile(
                    title: Text(
                      "Blog Link",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(
                      Icons.chrome_reader_mode_sharp,
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
