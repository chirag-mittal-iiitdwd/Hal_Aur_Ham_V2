import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hal_aur_ham_v2/Screens/Choose_Crop.dart';
import 'package:http/http.dart' as http;


import '../Screens/Crop_Scan.dart';
import '../Screens/Loading_Screen.dart';
import '../Screens/Scan_Result.dart';

class API extends StatefulWidget {

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {

  @override
  Widget build(BuildContext context) {
    onUploadImage() async {
      setState(() {
        var isLoading = true;
        Navigator.of(context).pushNamed(LoadingScreen.routeName);
      });
      var apiAddress;
      if (selected_crop == 'Maize')
        apiAddress = "https://maizeanomaly.herokuapp.com/predict/image";
      else
        apiAddress = "https://appleanomaly.herokuapp.com/predict/image";

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(apiAddress),
      );

      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      request.files.add(
        http.MultipartFile(
          'file',
          picked_image.readAsBytes().asStream(),
          picked_image.lengthSync(),
          filename: picked_image.path.split('/').last,
        ),
      );
      request.headers.addAll(headers);
      print("request: " + request.toString());
      var res = await request.send();
      http.Response response = await http.Response.fromStream(res);
      setState(
        () {
          isLoading = false;
          isAnomaly = jsonDecode(response.body);
          Navigator.of(context).pushReplacementNamed(ScanResult.routeName);
        },
      );
    }
    
  }
}