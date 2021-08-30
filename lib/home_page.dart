import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:projem/sekiller.dart';
import 'package:projem/hayvanlar.dart';
import 'package:projem/meslekler.dart';
import 'package:projem/meyveler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:projem/harfler.dart';
import 'package:projem/sayilar.dart';
import 'package:projem/sebzeler.dart';
import 'package:projem/tasit.dart';
import 'package:projem/vucut.dart';
import 'package:projem/yemek.dart';
import 'signin_page.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//deneme alanı
//  Future<SharedPreferences> pref = SharedPreferences.getInstance();

//  int progress =  pref.getInt('progress')!;

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.grey.shade400,
        appBar: AppBar(
          backgroundColor:Colors.grey.shade400,
          title: Text("İngilizce Öğreniyorum",),
         actions: [
             Builder(
               builder: (context) => IconButton(
                 icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                   await _auth.signOut();//firebaseden çıkmaya yarar

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Başarıyla çıkış yapıldı"),
                     ));

                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SignInPage(),
                  ));//bunu kullanma amacımız çıkış tuşuna bastığımız halde geri tuşuna basarsak giriş yapılmış halde duracağından pushReclacement kullanılır
                },),
                 )
              ],),
     body:Container(
      child:GridView.count(crossAxisCount: 2,
          children: [
           Column(
             children: [
               Container(
                 margin:EdgeInsets.only(top:10.0,left:20.0),
                 width:180.0,
                 height:180.0,
                 decoration:BoxDecoration(
                   color:Colors.purpleAccent.shade100
                 ),
                 child:Container(
                   width:50.0,
                   height:50.0,
                   color:Colors.red,
                   child:Image.asset("page_images/alfabe.png",width:85.0,),
                 ),

               )
             ],
           )




          ],
      ),
    )
    );
  }
}
