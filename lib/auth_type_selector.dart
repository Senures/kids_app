import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projem/home_page.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:projem/register_page.dart';
import 'register_page.dart';
import 'signin_page.dart';

/// Bir kimlik doğrulama türü [Authentication Type] seçmek için
/// bir UI [User Interface] sağlar.
class AuthTypeSelector extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Color(0xfffff3e0),
      body:Column(
        children: [
          Container(

              margin:EdgeInsets.only(top:120.0,left:40.0,right:10.0),
              child: Row(
                children: [
                  Image.asset("resimler/auth1.png",width:80.0,),
                  SizedBox(width:18.0,),
                  Text("Merhaba, hoş geldin",style:GoogleFonts.breeSerif(color:Color(0xffef9a9a),fontSize:22.0),)
                ],
              )),
          SizedBox(height:34.0,),


          Container(
            child:TextButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                    FirebaseAuth.instance.currentUser == null
                        ? SignInPage()
                        : HomePage(),
                  ),
                ),

                icon:Icon(Icons.email_rounded,color:Colors.white,size:24.0,) ,
                label:Text("Giriş Yap",style:GoogleFonts.breeSerif(color:Colors.white,fontSize:19.0),),),
            width:300.0,
            height:50.0,
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(20.0),
              color:Color(0xffffcc80),
            ),
           ),
          SizedBox(height:24.0,),
          Container(
            child:TextButton.icon(
              onPressed: ()=> Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              ),

              icon:Icon(Icons.person_add,color:Colors.white,size:24.0,) ,
              label:Text("Kayıt Ol",style:GoogleFonts.breeSerif(color:Colors.white,fontSize:19.0),),),
            width:300.0,
            height:50.0,
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(20.0),
              color:Color(0xffffcc80),
            ),
          ),

          SizedBox(height:20.0,),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(

              child: Container(
                width:250.0,
                height: 250,
                decoration:BoxDecoration(
                  color:Color(0xfffff3e0),
                  // borderRadius:BorderRadius.circular(190.0)
                ),
                margin:EdgeInsets.all(20.0),
                child:Center(child:Image.asset("resimler/auth2.png",width:180.0,)),
              ),
            ),
          ),
          SizedBox(height:5.0,),



        ],
      )

    );
  }
}
