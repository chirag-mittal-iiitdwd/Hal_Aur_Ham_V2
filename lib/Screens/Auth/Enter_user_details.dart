import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hal_aur_ham_v2/Components/LogoutButton.dart';
import 'package:hal_aur_ham_v2/Components/user_image_picker.dart';
import 'package:hal_aur_ham_v2/Screens/Auth/Widgets/CustomTextFormField.dart';
import 'package:hal_aur_ham_v2/Screens/WelcomeScreen/WelcomeScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart' as loc;

class RegiserationForm extends StatefulWidget {
  @override
  State<RegiserationForm> createState() => _RegiserationFormState();
}

class _RegiserationFormState extends State<RegiserationForm> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String aadhar;
  File _userImageFile;
  double lat;
  double lon;
  bool _isloading = false;

  void _saveName(String value) {
    name = value;
  }

  void _saveAadhar(String value) {
    aadhar = value;
  }

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _submitToDB() async {
    final curUser = FirebaseAuth.instance.currentUser;
    final locData = await loc.Location().getLocation();
    lat = locData.latitude;
    lon = locData.longitude;

    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(curUser.uid + '.jpg');

    await ref.putFile(_userImageFile).whenComplete(() => null);

    final url = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('users').doc(curUser.uid).set(
      {
        'name': name,
        'phone': curUser.phoneNumber,
        'aadhar': aadhar,
        'image_url': url,
        'latitude': lat,
        'longitude': lon,
      },
    );

    setState(() {
      _isloading = false;
    });

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }

  void _trySubmit() {
    setState(() {
      _isloading = true;
    });
    final isVaild = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please Pick An Image',
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isloading = false;
      });
      return;
    }

    if (isVaild) {
      _formKey.currentState.save();
      _submitToDB();
    } else {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Scaffold(
              body: Stack(
                children: [
                  Image.asset(
                    'Assets/Images/farm_back.jpg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 28.w),
                            child: Text(
                              'Registeration Form',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 32.sp,
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                UserImagePicker(_pickedImage),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 35.w,
                                    vertical: 8.h,
                                  ),
                                  child: CustomTextFormField(
                                    errorMessage: "Name Cannot be empty",
                                    saveVariable: _saveName,
                                    valueKey: "Name",
                                    inputlength: 10000,
                                    keyboardType: TextInputType.name,
                                    hintTextValue: 'Full Name',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 35.w,
                                    vertical: 8.h,
                                  ),
                                  child: CustomTextFormField(
                                    errorMessage:
                                        "Aadhar Should be exactly 12 digits long",
                                    saveVariable: _saveAadhar,
                                    valueKey: "Aadhar",
                                    inputlength: 12,
                                    keyboardType: TextInputType.number,
                                    hintTextValue: 'Aadhar Number',
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff0876B5),
                                  ),
                                  onPressed: _isloading ? null : _trySubmit,
                                  child: _isloading
                                      ? CircularProgressIndicator()
                                      : Text("Submit Details"),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                LogoutButton(
                                  Buttontext: "Use Different Number ?",
                                ),
                              ],
                            ),
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
