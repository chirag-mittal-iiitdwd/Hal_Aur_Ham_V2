import 'package:flutter/cupertino.dart';
import 'package:hal_aur_ham_v2/Screens/Profile/Profile_Screen.dart';

class ProfileDetails {
  final String name;
  final String aadhar;
  final String mobile;
  final String address;
  final String imgUrl;
  ProfileDetails(
      {this.address, this.aadhar, this.mobile, this.name, this.imgUrl});
}

class UserProfile with ChangeNotifier {
  final detail = ProfileDetails(
    address: "Borivali, Mumbai",
    mobile: '1234567890',
    name: "Ram Prasad",
    aadhar: '1111-2222-3333',
    imgUrl:
        'https://images.nightcafe.studio//assets/profile.png?tr=w-1600,c-at_max',
  );

  ProfileDetails get user {
    return detail;
  }
}
