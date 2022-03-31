import 'package:flutter/material.dart';
import 'package:hal_aur_ham_v2/Components/NewsCarasoul.dart';
import '../Components/App_Drawer.dart';

class WelcomeScreen extends StatelessWidget {
  static const routName = '/welcomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Stack(
        children: [
          Image.asset(
            'Assets/Images/farm_back.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          NewsCarasoul(),
        ],
      ),
    );
  }
}
