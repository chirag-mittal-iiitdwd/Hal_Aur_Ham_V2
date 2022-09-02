import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLocation extends StatelessWidget {
  const ChangeLocation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 

    ElevatedButton.icon(
      onPressed: null,
      icon: Icon(
        Icons.location_pin,
        color: Colors.black,
      ),
      label: Text('Change Loc'),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 5, 128, 34),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
