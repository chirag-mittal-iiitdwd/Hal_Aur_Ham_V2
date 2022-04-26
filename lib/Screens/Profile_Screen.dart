import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Screens/Login_Register.dart';
import 'package:provider/provider.dart';

import '../Components/App_Drawer.dart';
import '../Model/ProfileModel.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<UserProfile>(context);
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
                    child: Column(
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
                              backgroundImage: NetworkImage(
                                profileData.user.imgUrl,
                              ),
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
                                  featureContent: profileData.user.name,
                                  featureText: 'Name',
                                  iconName: Icon(Icons.person),
                                ),
                                ProfileItem(
                                  featureContent: profileData.user.aadhar,
                                  featureText: 'Aadhar',
                                  iconName: Icon(Icons.credit_card),
                                ),
                                ProfileItem(
                                  featureContent: profileData.user.mobile,
                                  featureText: 'Phone No',
                                  iconName: Icon(Icons.phone),
                                ),
                                ProfileItem(
                                  featureContent: profileData.user.address,
                                  featureText: 'Location',
                                  iconName: Icon(Icons.location_pin),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
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
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    LoginRegister.routeName);
                              },
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
