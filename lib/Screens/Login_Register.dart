import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Screens/WelcomeScreen.dart';

enum AuthMode { Login, Register }

class LoginRegister extends StatefulWidget {
  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        // Container(
                        //   margin: EdgeInsets.only(
                        //     top: 25.h,
                        //   ),
                        //   child: Text(
                        //     'Hal Aur Ham',
                        //     style: TextStyle(
                        //       fontSize: 18.sp,
                        //       fontWeight: FontWeight.w900,
                        //     ),
                        //   ),
                        // ),
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
                            _authMode == AuthMode.Login ? 'Login' : 'Register',
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
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  autofocus: false,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Mobile No',
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
                              if (_authMode == AuthMode.Register)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 35.w,
                                    vertical: 8.h,
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
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
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 35.w,
                                  vertical: 8.h,
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  autofocus: false,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
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
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                ),
                              ),
                              if (_authMode == AuthMode.Register)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 35.w,
                                    vertical: 8.h,
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    autofocus: false,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Confirm Password',
                                      filled: true,
                                      fillColor: Color(0x99FFDFB0),
                                      contentPadding: const EdgeInsets.only(
                                        left: 14,
                                        bottom: 6.0,
                                        top: 8.0,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x99FFDFB0),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff0876B5),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      WelcomeScreen.routName);
                                },
                                child: Text("Submit"),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                right: 10.w,
                                top: 8.h,
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  'Assets/Images/linkedin.png',
                                  height: 90.h,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                right: 10.w,
                                top: 8.h,
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.facebook,
                                  size: 50.h,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                right: 10.w,
                                top: 8.h,
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  'Assets/Images/twitter.png',
                                  height: 90.h,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              footer: FlatButton(
                color: Color(0x8A1A6114),
                child: GridTileBar(
                  title: Text(
                    _authMode == AuthMode.Register
                        ? 'Login Instead'
                        : 'Register Instead',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (_authMode == AuthMode.Login) {
                      _authMode = AuthMode.Register;
                    } else {
                      _authMode = AuthMode.Login;
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
