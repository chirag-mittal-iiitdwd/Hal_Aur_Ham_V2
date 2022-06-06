import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hal_aur_ham_v2/Screens/WelcomeScreen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationId;
  VerifyOtpScreen({this.verificationId});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeScreen(),
            ));
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: GridTile(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    color: Color(0xA8FFDFB0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 80.w),
                            margin: EdgeInsets.only(top: 10.h),
                            child: Image.asset('Assets/Images/App_Logo.png'),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 5.h,
                            ),
                            child: Text(
                              'Enter OTP',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextField(
                            controller: otpController,
                            maxLength: 6,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "6-Digit OTP",
                              counterText: "",
                            ),
                            
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CupertinoButton(
                            onPressed: () {
                              verifyOTP();
                            },
                            color: Colors.blue,
                            child: Text("Verify"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
