import 'package:flutter/cupertino.dart';

class CropData {
  String cropName;
  String cropPath;

  CropData({@required this.cropName,@required this.cropPath});
}

var CropArray = [
  CropData(cropName: "Apple",cropPath: 'Assets/Images/Apple.jpeg'),
  CropData(cropName: "Grape", cropPath: 'Assets/Images/grape.png')
];
