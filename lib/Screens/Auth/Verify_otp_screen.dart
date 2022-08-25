import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Screens/Auth/Widgets/CustomTextFormField.dart';

import 'package:hal_aur_ham_v2/Screens/WelcomeScreen/WelcomeScreen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationId;
  VerifyOtpScreen({this.verificationId});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _otp;
  void _saveOtp(value) {
    _otp = value;
  }

  void verifyOTP() async {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      _otp.trim();

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: _otp);

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
                    child: Center(
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
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 35.w,
                                      vertical: 8.h,
                                    ),
                                    child: CustomTextFormField(
                                      errorMessage:
                                          "OTP Should be exactly 6 digits long",
                                      saveVariable: _saveOtp,
                                      valueKey: "Otp",
                                      hintTextValue: "Enter Otp",
                                      inputlength: 6,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff0876B5),
                                    ),
                                    onPressed: verifyOTP,
                                    child: Text("Submit"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
