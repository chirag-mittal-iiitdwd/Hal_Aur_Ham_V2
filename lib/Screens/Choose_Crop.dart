import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Screens/Crop_Scan.dart';

import '../Components/App_Drawer.dart';

var selected_crop;

class chooseCrop extends StatelessWidget {
  static const routeName = '/chooseCrop';

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    margin: EdgeInsets.only(top: 50.h),
                    child: Column(
                      children: [
                        Text(
                          'Select your crop',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 32.sp,
                          ),
                        ),
                        CropCatalog(),
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

class CropCatalog extends StatefulWidget {
  @override
  State<CropCatalog> createState() => _CropCatalogState();
}

class _CropCatalogState extends State<CropCatalog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: GlowContainer(
        height: 600.h,
        margin: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: 2.w,
        ),
        padding: EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w),
        // glowColor: Color(0xB0FFDFB0),
        borderRadius: BorderRadius.circular(30.r),
        color: Color(0xB0FFDFB0),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: FlatButton(
                            onPressed: () {
                              selected_crop = 'Apple';
                              Navigator.of(context)
                                  .pushNamed(CropScan.routeName);
                            },
                            child: Container(
                              width: 100.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.asset(
                                  'Assets/Images/Apple.jpeg',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("Apple")
                      ],
                    ),
                    Column(
                      children: [
                        FlatButton(
                            onPressed: () {
                              selected_crop = 'Maize';
                              Navigator.of(context)
                                  .pushNamed(CropScan.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Image.asset(
                                    'Assets/Images/Maize.jpeg',
                                    height: 100.h,
                                    width: 100.h,
                                    fit: BoxFit.fill,
                                  )),
                            )),
                        Text("Maize")
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       children: [
                //         FlatButton(
                //             onPressed: () {
                //               selected_crop = 'Tomato';
                //               //Navigator.of(context).pushNamed(CropScan.routeName);
                //             },
                //             child: Container(
                //               decoration: BoxDecoration(
                //                   border: Border.all(color: Colors.black26),
                //                   borderRadius: BorderRadius.circular(20.r)),
                //               child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(20.r),
                //                   child: Image.asset(
                //                     'Assets/Images/Tomato.jpeg',
                //                     height: 100.h,
                //                     width: 100.h,
                //                     fit: BoxFit.fill,
                //                   )),
                //             )),
                //         Text("Tomato")
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         FlatButton(
                //             onPressed: () {
                //               selected_crop = 'Potato';
                //               //Navigator.of(context).pushNamed(CropScan.routeName);
                //             },
                //             child: Container(
                //               decoration: BoxDecoration(
                //                   border: Border.all(color: Colors.black26),
                //                   borderRadius: BorderRadius.circular(20.r)),
                //               child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(20.r),
                //                   child: Image.asset(
                //                     'Assets/Images/Potato.jpeg',
                //                     height: 100.h,
                //                     width: 100.h,
                //                     fit: BoxFit.fill,
                //                   )),
                //             )),
                //         Text("Potato")
                //       ],
                //     ),
                //   ],
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
