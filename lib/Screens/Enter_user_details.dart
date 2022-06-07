import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hal_aur_ham_v2/Screens/WelcomeScreen.dart';

class RegiserationForm extends StatefulWidget {
  @override
  State<RegiserationForm> createState() => _RegiserationFormState();
}

class _RegiserationFormState extends State<RegiserationForm> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String aadhar;

  void _trySubmit() async {
    final curUser = FirebaseAuth.instance.currentUser;
    final isVaild = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isVaild) {
      _formKey.currentState.save();
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Note'),
          content: Text(
              'Are you sure you want to submit these deatils ? You Wont be able to change these if you submit...'),
          actions: [
            FlatButton(
              onPressed: () {
                return;
              },
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("Yes"),
            ),
          ],
        ),
      );

      await FirebaseFirestore.instance.collection('users').doc(curUser.uid).set(
        {
          'name': name,
          'phone': curUser.phoneNumber,
          'aadhar': aadhar,
        },
      );

      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
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
                  Container(
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
                            children: [
                              SizedBox(
                                height: 30.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 35.w,
                                  vertical: 8.h,
                                ),
                                child: TextFormField(
                                  key: ValueKey('name'),
                                  validator: (value) {
                                    if (value.length != 0) {
                                      return null;
                                    }
                                    return 'Name cannot be empty';
                                  },
                                  onSaved: (value) {
                                    print(value);
                                    name = value;
                                  },
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Full Name',
                                    filled: true,
                                    fillColor: Color(0x99FFDFB0),
                                    contentPadding: const EdgeInsets.only(
                                      left: 14.0,
                                      bottom: 6.0,
                                      top: 8.0,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x99FFDFB0),
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 35.w,
                                  vertical: 8.h,
                                ),
                                child: TextFormField(
                                  key: ValueKey('aadhar'),
                                  validator: (value) {
                                    if (value.length == 12) {
                                      return null;
                                    }
                                    return 'Aadhar number must be 12 digits long';
                                  },
                                  onSaved: (value) {
                                    aadhar = value;
                                  },
                                  keyboardType: TextInputType.phone,
                                  autofocus: false,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Aadhar Number',
                                    filled: true,
                                    fillColor: Color(0x99FFDFB0),
                                    contentPadding: const EdgeInsets.only(
                                      left: 14.0,
                                      bottom: 6.0,
                                      top: 8.0,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x99FFDFB0),
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff0876B5),
                                ),
                                onPressed: _trySubmit,
                                child: Text("Submit Details"),
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
          ],
        ),
      ),
    );
  }
}
