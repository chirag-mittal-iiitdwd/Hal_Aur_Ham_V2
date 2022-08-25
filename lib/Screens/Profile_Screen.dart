import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Screens/Auth/Login_Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../Components/App Drawer/App_Drawer.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false;
  String userName = '';
  String aadhar = '';
  String phone = '';
  String _image = '';
  // File file;

  // Future<File> urlToFile(String imageUrl) async {
  //   final response = await http.get(Uri.parse(imageUrl));
  //   await file.writeAsBytes(response.bodyBytes);
  //   return file;
  // }

  void yourFunction(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final uid = FirebaseAuth.instance.currentUser.uid;
    final currentUserData =
        await FirebaseFirestore.instance.doc('users/' + uid).get();
    userName = currentUserData['name'];
    aadhar = currentUserData['aadhar'];
    phone = currentUserData['phone'];
    _image = currentUserData['image_url'];
    // file = await urlToFile(_image);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => yourFunction(context));
  }

  @override
  Widget build(BuildContext context) {
    void logOut() async {
      await FirebaseAuth.instance.signOut();
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginRegister(),
        ),
      );
    }

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
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.yellow,
                          Colors.orange,
                          Colors.green,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.h),
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 28.w,
                                ),
                                child: Text(
                                  'Your Profile',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 110.r,
                                    backgroundImage: NetworkImage(_image),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 28.w),
                                height: 270.h,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  color: Color(0xa8FFDFB0),
                                  child: Column(
                                    children: [
                                      ProfileItem(
                                        featureContent: userName,
                                        featureText: 'Name',
                                        iconName: Icon(Icons.person),
                                      ),
                                      ProfileItem(
                                        featureContent: aadhar,
                                        featureText: 'Aadhar',
                                        iconName: Icon(Icons.credit_card),
                                      ),
                                      ProfileItem(
                                        featureContent: phone,
                                        featureText: 'Phone No',
                                        iconName: Icon(Icons.phone),
                                      ),
                                      ProfileItem(
                                        featureContent: 'To be Updated...',
                                        featureText: 'Location',
                                        iconName: Icon(Icons.location_pin),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Navigator.of(context).pushReplacementNamed(
                                      //     LoginRegister.routeName);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Change Location  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.sp,
                                          ),
                                        ),
                                        Icon(
                                          Icons.location_pin,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              LoginRegister.routeName);
                                    },
                                    child: GestureDetector(
                                      onTap: logOut,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Logout  ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22.sp,
                                            ),
                                          ),
                                          Icon(
                                            Icons.logout,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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

class ProfileItem extends StatelessWidget {
  final String featureText;
  final Icon iconName;
  final String featureContent;
  ProfileItem({this.featureContent, this.featureText, this.iconName});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
              ),
              iconName,
              Text(
                " ",
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Text(
                featureText,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Text(
                "   :   ",
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Text(
                featureContent,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
