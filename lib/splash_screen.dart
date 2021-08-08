import 'package:flutter/material.dart';
import 'package:projem/auth_type_selector.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>AuthTypeSelector()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color:Colors.orange,
            image: DecorationImage(
              image: AssetImage("resimler/splash.png"),
              fit: BoxFit.contain,)),
      ),
    );
  }
}

