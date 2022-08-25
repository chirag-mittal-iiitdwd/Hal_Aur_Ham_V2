import 'package:flutter/material.dart';

class ChangeLocation extends StatelessWidget {
  const ChangeLocation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return ElevatedButton.icon(
      onPressed: null, 
      icon: Icon(Icons.location_pin,color: Colors.black,), 
      label: Text('Change Location'),style: ElevatedButton.styleFrom(primary:Colors.red[800],),);
  }
}