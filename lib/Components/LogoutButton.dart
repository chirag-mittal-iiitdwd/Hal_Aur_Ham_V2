import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hal_aur_ham_v2/Screens/Auth/Login_Register.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutButton extends StatelessWidget {
  final String Buttontext;
  LogoutButton({@required this.Buttontext});

  @override
  Widget build(BuildContext context) {
    void logOut() async {
      await FirebaseAuth.instance.signOut();
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginRegister(),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: logOut, 
      icon: Icon(Icons.logout,color: Colors.black,), 
      label: Text(Buttontext),style: ElevatedButton.styleFrom(primary:Colors.red[800],),);
  }
}
