import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hal_aur_ham_v2/Screens/Auth/Verify_otp_screen.dart';
import 'package:hal_aur_ham_v2/Screens/Auth/Widgets/CustomTextFormField.dart';

// enum AuthMode { Login, Register }

class LoginRegister extends StatefulWidget {
  static const routeName = '/login_register';
  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _phoneNumber;
  bool _isLoading = false;

  void _savePhoneNumber(String value) {
    _phoneNumber = value;
  }

  void sendOTP() async {
    String phone = "+91" + _phoneNumber.trim();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId, resendToken) {
        print('code sent');
        setState(() {
          _isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyOtpScreen(
              verificationId: verificationId,
            ),
          ),
        );
      },
      verificationCompleted: (credential) {
        // await print('verification completed');
      },
      verificationFailed: (ex) {
        // log(ex.code.toString());
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: Duration(seconds: 120),
    );
  }

  void _trySubmit(){
    setState(() {
      _isLoading = true;
    });
    FocusScope.of(context).unfocus();
    final isVaild = _formKey.currentState.validate();
    if (isVaild) {
      _formKey.currentState.save();
      sendOTP();
      print(_phoneNumber);
    }

    setState(() {
      _isLoading = false;
    });
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
                              "Please Enter Your Mobile No",
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
                                        "Phone Number should be exactly 10 digits long",
                                    saveVariable: _savePhoneNumber,
                                    valueKey: "Phone",
                                    inputlength: 10,
                                    keyboardType: TextInputType.phone,
                                    hintTextValue: 'Phone No',
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff0876B5),
                                  ),
                                  onPressed: _isLoading ? null : _trySubmit,
                                  child: _isLoading
                                      ? CircularProgressIndicator()
                                      : Text("Submit"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
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
