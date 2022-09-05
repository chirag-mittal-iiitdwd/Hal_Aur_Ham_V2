import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_aur_ham_v2/Screens/Crop%20Scan/Crop_Scan.dart';

import '../../Components/App Drawer/App_Drawer.dart';
import '../../Model/CropData.dart';

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

class CropCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      child: GlowContainer(
        height: 600.h,
        margin: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: 2.w,
        ),
        padding: EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w),
        // glowColor: Color(0xB0FFDFB0),
        borderRadius: BorderRadius.circular(30.r),
        color: Color(0xB0FFDFB0),
        child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 20.h),
          itemCount: CropArray.length,
          itemBuilder: (ctx, i) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: Colors.black,
                width: .4.w,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: GestureDetector(
                onTap: () {
                    Navigator.of(context).pushNamed(CropScan.routeName,
                        arguments: {'selectedCrop': CropArray[i].cropName});
                  },
                child: GridTile(
                  child: Image.asset(
                    CropArray[i].cropPath,
                    fit: BoxFit.cover,
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(CropArray[i].cropName),
                  ),
                ),
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
          ),
        ),
      ),
    );
  }
}
