import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projem/home_page.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:projem/register_page.dart';
import 'register_page.dart';
import 'signin_page.dart';
import 'package:google_fonts/google_fonts.dart';

/// Bir kimlik doğrulama türü [Authentication Type] seçmek için
/// bir UI [User Interface] sağlar.
class AuthTypeSelector extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Uygulama Giriş Ekranı",),
      ),
    body: Column(

        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //? Logo
          Container(
           // margin: const EdgeInsets.only(bottom: 0.0),
            height: 250.0,
            width:250,
            decoration: BoxDecoration(
              image: DecorationImage(

                alignment: Alignment.center,
                image:AssetImage("resimler/balonn.png"),
                fit: BoxFit.fill,
              ),
              //shape: BoxShape.circle,
            ),
          ),
          Padding(padding:EdgeInsets.all(20.0)),

          //? Kayıt Ol Buttonu
          Container(
            child: SignInButtonBuilder(
              icon: Icons.person_add,
              backgroundColor: Colors.purple,
              text: "Kayıt Ol",
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
          ),
          //? Giriş Yap Buttonu
          Container(
            child: SignInButtonBuilder(
              icon: Icons.email,
              backgroundColor: Colors.blue,
              text: "Giriş Yap",
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                  FirebaseAuth.instance.currentUser == null
                      ? SignInPage()
                      : HomePage(),
                ),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
