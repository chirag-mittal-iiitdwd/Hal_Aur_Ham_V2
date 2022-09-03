import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Components/App%20Drawer/App_Drawer.dart';
import 'package:hal_aur_ham_v2/Screens/Choose_Crop.dart';
import 'package:hal_aur_ham_v2/Screens/Scan_Result.dart';
import 'package:hal_aur_ham_v2/Screens/Scan_Result_Copy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'Loading_Screen.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

ImagePicker picker = ImagePicker();
var picked_image;
var isLoading = false;
var isLeaf = false;

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
  /// Returns a cropped copy of [src].

  onUploadImage() async {
    setState(() {
      var isLoading = true;
      Navigator.of(context).pushNamed(LoadingScreen.routeName);
    });
    var apiAddress =
        "https://detect.roboflow.com/detection2onwhole/8?api_key=ANr5ozpqqr3sL8croyQm";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(apiAddress),
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
    var decodedResults = jsonDecode(response.body);
    print(decodedResults);

    if (decodedResults['predictions'].length != 0) {
      var decoded1 = decodedResults['predictions'][0];

      File cropped_leaf = await FlutterNativeImage.cropImage(
          picked_image.path,
          (decoded1['x'] - decoded1['width'] / 2).round(),
          (decoded1['y'] - decoded1['height'] / 2).round(),
          (decoded1['width']).round(),
          (decoded1['height']).round());

      picked_image = cropped_leaf;
      isLeaf = true;
    } else {
      isLeaf = false;
    }

    setState(
      () {
        isLoading = false;
        Navigator.of(context).pushReplacementNamed(scanResultCopy.routeName);
      },
    );
  }

  Future openCamera() async {
    setState(() {
      var isLoading = true;
      Navigator.of(context).pushNamed(LoadingScreen.routeName);
    });
    final camera_img = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (camera_img != null) {
      var cropped_image = await ImageCropper().cropImage(
        sourcePath: camera_img.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            lockAspectRatio: false,
            statusBarColor: Colors.black,
          ),
        ],
      );
      picked_image = File(cropped_image.path);

      setState(() {
        onUploadImage();
      });
    }
  }

  Future openGallery() async {
    final gallery_img = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (gallery_img != null) {
      var cropped_image = await ImageCropper().cropImage(
        sourcePath: gallery_img.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            lockAspectRatio: false,
            statusBarColor: Colors.black,
          ),
        ],
      );
      picked_image = File(cropped_image.path);
      setState(() {
        onUploadImage();
      });
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
