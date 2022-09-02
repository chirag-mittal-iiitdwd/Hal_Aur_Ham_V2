import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hal_aur_ham_v2/Screens/Auth/Widgets/CustomTextFormField.dart';
import 'package:hal_aur_ham_v2/Screens/WelcomeScreen/WelcomeScreen.dart';

enum VerifyState {
  formState,
  otpState,
}

class LoginRegister extends StatefulWidget {
  static const routeName = '/login_register';
  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  VerifyState currentState = VerifyState.formState;
  final _phoneFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  String _phone;
  String _otp;
  String _verificationId;
  bool _isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  void signInWithPhoneAuthCRedential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        _isLoading = false;
      });

      if (authCredential.user != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  void _validateAndSubmitPhone() async {
    setState(() {
      _isLoading = true;
    });
    bool isValid = _phoneFormKey.currentState.validate();
    if (isValid) {
      FocusScope.of(context).unfocus();
      _phoneFormKey.currentState.save();
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91" + _phone,
        verificationCompleted: (phoneAuthCredential) async {
          setState(() {
            _isLoading = false;
          });
          signInWithPhoneAuthCRedential(phoneAuthCredential);
        },
        verificationFailed: (verificationFailed) async {
          setState(() {
            _isLoading = false;
          });
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(verificationFailed.message),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        },
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            _isLoading = false;
            currentState = VerifyState.otpState;
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content:
                  Text("Timeout !!, Please enter another OTP we just sent you"),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );

          setState(() {
            verificationId = verificationId;
          });
        },
        timeout: Duration(seconds: 30),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _validateOtpAndVerify() async {
    bool isValid = _otpFormKey.currentState.validate();
    if (isValid) {
      FocusScope.of(context).unfocus();
      _otpFormKey.currentState.save();
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otp,
      );

      signInWithPhoneAuthCRedential(phoneAuthCredential);
    }
  }

  getForm(BuildContext contex) {
    void _savePhone(value) {
      _phone = value;
    }

    return Form(
      key: _phoneFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 35.w,
              vertical: 8.h,
            ),
            child: CustomTextFormField(
              errorMessage: "Phone Number should be exactly 10 digits long",
              saveVariable: _savePhone,
              valueKey: "Phone",
              inputlength: 10,
              keyboardType: TextInputType.phone,
              hintTextValue: 'Phone Number',
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff0876B5),
            ),
            onPressed: _isLoading ? null : _validateAndSubmitPhone,
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }

  getOtp(BuildContext contex) {
    void _saveOtp(value) {
      _otp = value;
    }

    return Form(
      key: _otpFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 35.w,
              vertical: 8.h,
            ),
            child: CustomTextFormField(
              errorMessage: "Otp Should be exactly 6 digits long",
              saveVariable: _saveOtp,
              valueKey: "otp",
              inputlength: 6,
              keyboardType: TextInputType.number,
              hintTextValue: 'Enter Otp',
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff0876B5),
            ),
            onPressed: _isLoading ? null : _validateOtpAndVerify,
            child: Text("Verify"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
                                currentState == VerifyState.formState
                                    ? "Enter Your Mobile Number"
                                    : "Enter the OTP",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            _isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : currentState == VerifyState.formState
                                    ? getForm(context)
                                    : getOtp(context),
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
            ),
          ],
        ),
      ),
    );
  }
}
