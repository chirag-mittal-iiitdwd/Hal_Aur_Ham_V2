// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hal_aur_ham_v2/Crop%20Scan/Choose%20Crop/Choose_Crop.dart';
// import 'package:http/http.dart' as http;

// import '../Crop Scan/Crop_Scan.dart';
// import '../Crop Scan/Loading_Screen.dart';
// import '../Crop Scan/Scan_Result.dart';

// var isAnomaly;

// class API extends StatefulWidget {
//   @override
//   State<API> createState() => _APIState();
// }

// class _APIState extends State<API> {
//   @override
//   Widget build(BuildContext context) {
//     onUploadImage() async {
//       setState(() {
//         var isLoading = true;
//         Navigator.of(context).pushNamed(LoadingScreen.routeName);
//       });
//       var apiAddress;
//       if (selected_crop == 'Maize')
//         apiAddress = "https://maizeanomaly.herokuapp.com/predict/image";
//       else
//         apiAddress = "https://appleanomaly.herokuapp.com/predict/image";

//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(apiAddress),
//       );

//       Map<String, String> headers = {"Content-type": "multipart/form-data"};
//       request.files.add(
//         http.MultipartFile(
//           'file',
//           picked_image.readAsBytes().asStream(),
//           picked_image.lengthSync(),
//           filename: picked_image.path.split('/').last,
//         ),
//       );
//       request.headers.addAll(headers);
//       print("request: " + request.toString());
//       var res = await request.send();
//       http.Response response = await http.Response.fromStream(res);
//       setState(
//         () {
//           isLoading = false;
//           isAnomaly = jsonDecode(response.body);
//           Navigator.of(context).pushReplacementNamed(ScanResult.routeName);
//         },
//       );
//     }
//   }
// }
