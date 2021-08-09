import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:projem/sekiller.dart';
import 'package:projem/hayvanlar.dart';
import 'package:projem/meslekler.dart';
import 'package:projem/meyveler.dart';
import 'package:projem/register_page.dart';
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

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.orange.shade200,
        appBar: AppBar(
          backgroundColor:Colors.orange.shade200,
        title: Text("Uygulama anasayfa"),
         actions: [
             Builder(
               builder: (context) => IconButton(
                 icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                   await _auth.signOut();//firebaseden çıkmaya yarar

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Başarıyla çıkış yapıldı"),
                     ));

                 Navigator.pushReplacement(
    //bunu kullanma amacımız çıkış tuşuna bastığımız halde geri tuşuna basarsak giriş yapılmış halde duracağından pushReclacement kullanılır
    context,
    MaterialPageRoute(
    builder: (context) =>SignInPage(),
    ));
    },),
    )
    ],),
    body:Container(
      child:GridView.count(crossAxisCount: 2,
          children: [
            Card(
              margin:EdgeInsets.all(15.0),
              child:InkWell(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Harfler()));
                },
                splashColor:Colors.purple,

                child:Center(
                  child:Column(
                    mainAxisSize:MainAxisSize.min,
                    children: [
                      Image.asset("page_images/alfabe.png",width:75.0,),
                      Padding(padding:EdgeInsets.all(5.0)),
                      Text("Harfler",style:GoogleFonts.courgette(fontSize:22.0,color:Colors.purple,),
                      ),
                    ],
                  )
                ),
              ),
             ),

            Card(
              margin:EdgeInsets.all(15.0),
              child:InkWell(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Sayilar()));
                },
                splashColor:Colors.purple,
                child:Center(
                    child:Column(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Image.asset("page_images/sayilar.png",width:75.0,),
                        Padding(padding:EdgeInsets.all(5.0)),
                        Text("Sayılar",style:GoogleFonts.courgette(fontSize:22.0,color:Colors.blue,)),
                      ],
                    )
                ),
              ),
            ),
            Card(
              margin:EdgeInsets.all(15.0),
              child:InkWell(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Meyveler()));
                },
                splashColor:Colors.purple,
                child:Center(
                    child:Column(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Image.asset("page_images/meyve.png",width:75.0,),
                        Padding(padding:EdgeInsets.all(5.0)),
                        Text("Meyveler",style:GoogleFonts.courgette(fontSize:22.0,color:Colors.red,)),
                      ],
                    )
                ),
              ),
            ),Card(
              margin:EdgeInsets.all(15.0),
              child:InkWell(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Sebzeler()));
                },
                splashColor:Colors.purple,
                child:Center(
                    child:Column(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Image.asset("page_images/sebze.png",width:75.0,),
                        Padding(padding:EdgeInsets.all(5.0)),
                        Text("Sebzeler",style:GoogleFonts.courgette(fontSize:22.0,color:Colors.green,)),
                      ],
                    )
                ),
              ),
            ),
            Card(
              margin:EdgeInsets.all(15.0),
              child:InkWell(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Yemek()));
                },
                splashColor:Colors.purple,
                child:Center(
                    child:Column(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Image.asset("page_images/drink.png",width:75.0,),
                        Padding(padding:EdgeInsets.all(5.0)),
                        Text("Yeme - İçme",style:GoogleFonts.courgette(fontSize:22.0,color:Colors.brown,)),
                      ],
                    )
                ),
              ),
            ),
            Card(
              margin:EdgeInsets.all(14.0),
              child:InkWell(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Hayvanlar()));
                },
                splashColor:Colors.purple,
                child:Center(
                    child:Column(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Image.asset("page_images/hayvan.png",width:75.0,),
                        Padding(padding:EdgeInsets.all(5.0)),
                        Text("Hayvanlar",style:GoogleFonts.courgette(fontSize:22.0,color:Colors.teal,)),
                      ],
                    )
                ),
              ),
            ),
            Card(
              margin:EdgeInsets.all(15.0),
              child:InkWell(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Meslekler()));
                },
                splashColor:Colors.purple,
                child:Center(
                    child:Column(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Image.asset("page_images/job.png",width:75.0,),
                        Padding(padding:EdgeInsets.all(5.0)),
                        Text("Meslekler",style:GoogleFonts.courgette(fontSize:22.0,color:Colors.indigo,)),
                      ],
                    )
                ),
              ),
            ),
            Card(
              margin:EdgeInsets.all(15.0),
              child:InkWell(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Sekiller()));
                },
                splashColor:Colors.purple,
                child:Center(
                    child:Column(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Image.asset("page_images/shapes.png",width:75.0,),
                        Padding(padding:EdgeInsets.all(5.0)),
                        Text("Şekiller",style:GoogleFonts.courgette(fontSize:22.0,color:Colors.deepOrange),),
                      ],
                    )
                ),
              ),
            ),
            Card(
              margin:EdgeInsets.all(15.0),
              child:InkWell(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Vucut()));
                },
                splashColor:Colors.purple,
                child:Center(
                    child:Column(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Image.asset("page_images/body.png",width:75.0,),
                        Padding(padding:EdgeInsets.all(5.0)),
                        Text("Vücut",style:GoogleFonts.courgette(fontSize:22.0,color:Colors.purpleAccent)),
                      ],
                    )
                ),
              ),
            ),
            Card(
              margin:EdgeInsets.all(15.0),
              child:InkWell(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Tasit()));
                },
                splashColor:Colors.purple,
                child:Center(
                    child:Column(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Image.asset("page_images/tasit.png",width:75.0,),
                        Padding(padding:EdgeInsets.all(5.0)),
                        Text("Taşıtlar",style:GoogleFonts.courgette(fontSize:22.0,color:Colors.cyan,)),
                      ],
                    )
                ),
              ),
            ),
          ],
      ),
    )
    );
  }
}
