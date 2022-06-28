import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Components/App_Drawer.dart';

class CropVizScreen extends StatelessWidget {
  static const routeName = '/cropViz';
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
                    margin: EdgeInsets.only(
                      top: 40.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 28.w),
                          child: Text(
                            'Crop Vizualisation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 32.sp,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Text(
                                'Currently this feature is under construction',
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(
                        //       30.r,
                        //     ),
                        //     color: Color(0xa8FFDFB0),
                        //   ),
                        //   margin: EdgeInsets.symmetric(horizontal: 28.w),
                        //   padding: EdgeInsets.symmetric(
                        //     vertical: 15.h,
                        //     horizontal: 15.w,
                        //   ),
                        //   height: 630.h,
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(
                        //             30.r,
                        //           ),
                        //           color: Color(0x871A6114),
                        //         ),
                        //         height: 250.h,
                        //         width: 300.w,
                        //         child: Text("Viz 1"),
                        //       ),
                        //       SizedBox(
                        //         height: 20.h,
                        //       ),
                        //       Container(
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(
                        //             30.r,
                        //           ),
                        //           color: Color(0x871A6114),
                        //         ),
                        //         height: 250.h,
                        //         width: 300.w,
                        //         child: Text("Viz 2"),
                        //       )
                        //     ],
                        //   ),
                        // ),
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
