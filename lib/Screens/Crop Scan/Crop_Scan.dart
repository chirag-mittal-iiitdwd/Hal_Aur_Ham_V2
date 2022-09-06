import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Components/App%20Drawer/App_Drawer.dart';
import 'package:hal_aur_ham_v2/Screens/Crop%20Scan/Scan_Result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_native_image/flutter_native_image.dart';

class CropScan extends StatefulWidget {
  static const routeName = '/cropScan';

  @override
  State<CropScan> createState() => _CropScanState();
}

class _CropScanState extends State<CropScan> {
  ImagePicker picker = ImagePicker();
  var pickedImage;
  var results;
  var isLoading = false;
  var isLeaf = false;
  var selectedCrop;

  result(File image) async {
    var apiAddress;
    if (selectedCrop == "Apple") {
      apiAddress =
          "https://classify.roboflow.com/run-9o3th/1?api_key=pDqBzQpmauLOOlf9ubaD";
    } else if (selectedCrop == "Grape") {
      apiAddress =
          "https://classify.roboflow.com/go-yatxc/1?api_key=pDqBzQpmauLOOlf9ubaD";
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(apiAddress),
    );

    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        pickedImage.readAsBytes().asStream(),
        pickedImage.lengthSync(),
        filename: pickedImage.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);

    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    var decodedResults = jsonDecode(response.body);

    setState(() {
      results = decodedResults;
    });
  }

  onUploadImage() async {
    setState(() {
      isLoading = true;
    });
    var apiAddress =
        "https://detect.roboflow.com/apple-leaf-detection/2?api_key=4VHxMmXv2snZBRw1Qsq0";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(apiAddress),
    );

    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        pickedImage.readAsBytes().asStream(),
        pickedImage.lengthSync(),
        filename: pickedImage.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);

    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    var decodedResults = jsonDecode(response.body);

    if (decodedResults['predictions'].length != 0) {
      var decoded1 = decodedResults['predictions'][0];

      File cropped_leaf = await FlutterNativeImage.cropImage(
          pickedImage.path,
          (decoded1['x'] - decoded1['width'] / 2).round(),
          (decoded1['y'] - decoded1['height'] / 2).round(),
          (decoded1['width']).round(),
          (decoded1['height']).round());

      pickedImage = cropped_leaf;
      isLeaf = true;
    } else {
      isLeaf = false;
    }
    if (isLeaf) {
      await result(pickedImage);
    }

    setState(
      () {
        isLoading = false;
      },
    );
    Navigator.of(context).pushReplacementNamed(
      ScanResult.routeName,
      arguments: {
        'results': results,
        'isLeaf': isLeaf,
        'pickedImage': pickedImage
      },
    );
  }

  Future openCamera() async {
    final camera_img = await picker.pickImage(
      source: ImageSource.camera,
    );
    Navigator.of(context).pop();
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
      pickedImage = File(cropped_image.path);
      await onUploadImage();
    }
  }

  Future openGallery() async {
    final gallery_img = await picker.pickImage(
      source: ImageSource.gallery,
    );
    Navigator.of(context).pop();
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
      pickedImage = File(cropped_image.path);
      await onUploadImage();
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
                onPressed: (() => openGallery()),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Select Image From Gallery',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TextButton(
                onPressed: (() => openCamera()),
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
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    selectedCrop = routeArgs['selectedCrop'];
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
                  isLoading
                      ? Container(
                          padding: EdgeInsets.only(
                              top: 17.h, left: 17.w, right: 17.w),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.w, vertical: 20.h),
                              height: 200.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.r),
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hang on, we are getting the results.',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CircularProgressIndicator(),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 40.h),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 20.h),
                                child: GlowContainer(
                                  height: 450.h,
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
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          color: Colors.black54,
                                        ),
                                        height: 333.h,
                                      ),
                                      InkWell(
                                        child: Container(
                                            child: Image.asset(
                                                'Assets/Images/ScanCamera.png'),
                                            height: 100.h,
                                            width: 100.h),
                                        onTap: (() => UploadImageDialog()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
