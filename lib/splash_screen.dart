import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projem/auth_type_selector.dart';
import 'package:projem/home_page.dart';

class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds:3), () {
      if(_auth.currentUser!=null){//kullanıcı loginse anasayfayadan açılsın, değilse login sayfasına
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>HomePage() ));
      }
      else{
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>AuthTypeSelector() ));
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xfffbe9e7),
      body: Center(
        child:Container(
          child:Image.asset("resimler/ekran1.png",width:175.0,),
        ),

      ),
    );
  }
}

