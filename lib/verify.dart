import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projem/signin_page.dart';


class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds:2), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.orange[200],
      body: Column(
        children: [
          Center(
            child:Padding(
              padding: const EdgeInsets.only(top:80.0),
              child: Container(
                width:270.0,
                height:270.0,
                decoration:BoxDecoration(
                  color:Colors.orange[200],
                  borderRadius:BorderRadius.circular(20.0)
                ),
                child: Center(
                  child: Align(
                    alignment:Alignment.center,
                    child: Text(
                        'Adresine bir e-posta gönderildi, ${user.email} lütfen doğrulayın',
                      style:GoogleFonts.courgette(fontSize:23.0,color:Colors.white,
                      ),),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height:30.0,),
          Center(child:Image.asset("resimler/balon.png",width:220.0,height:220.0,)),
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignInPage()));
    }
  }
}