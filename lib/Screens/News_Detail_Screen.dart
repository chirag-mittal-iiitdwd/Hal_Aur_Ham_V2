import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  static const routeName = '/weatherDetail';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset(
              'Assets/Images/farm_back.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Container(
              child: Column(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
