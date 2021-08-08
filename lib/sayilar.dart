import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcard/tcard.dart';


class Sayilar extends StatefulWidget {

  @override
  _SayilarState createState() => _SayilarState();
}

class _SayilarState extends State<Sayilar> {
  TCardController _controller = TCardController();

  final List<String> imageList = [
    "https://image.flaticon.com/icons/png/512/4020/4020081.png",
    "https://image.flaticon.com/icons/png/512/4020/4020055.png",
    "https://image.flaticon.com/icons/png/512/4020/4020060.png",
    "https://image.flaticon.com/icons/png/512/4020/4020062.png",
    "https://image.flaticon.com/icons/png/512/4020/4020064.png",
    "https://image.flaticon.com/icons/png/512/4020/4020076.png",
    "https://image.flaticon.com/icons/png/512/4020/4020077.png",
    "https://image.flaticon.com/icons/png/512/4020/4020078.png",
    "https://image.flaticon.com/icons/png/512/4020/4020079.png",
    "https://image.flaticon.com/icons/png/512/4020/4020080.png",

  ];
  final List<String> sayilarList =[
    "Zero   Sıfır",
    " One   Bir","Two   İki ","Three   Üç","Four   Dört","Five   Beş","Six   Altı","Seven   Yedi","Eight   Sekiz","Nine   Dokuz",
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      sayilarList.length,
          (int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23.0,
                spreadRadius: -13.0,
                color: Colors.black54,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width:300.0,
                  height:250.0,
                  child: Image.network(
                    imageList[index],
                    fit: BoxFit.contain,
                  ),
                ),
                Text(sayilarList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 28.0, color: Colors.purpleAccent)),
              ],
            ),
          ),
        );
      },
    );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Center(
          child: Text(
            'Haydi  Sayılara  Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 20.0, color: Colors.purpleAccent),
          ),
        ),
      ),

      backgroundColor: Colors.green.shade100,
      body: Column(
        children: [
          SizedBox(
            height:30.0,
          ),
          TCard(
            cards: cards,
            size: Size(size.width * 2.8, size.height * .6),
            controller: _controller,
            onForward: (index, info) {
              print(index);
              // BUTONLARIN TIKLANINCA NE OLACAGINI BELİRLERİZ
            },
            onBack: (index, info) {
              print(index);
            },
            onEnd: () {
              _controller.reset();
              print('end');
            },
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  onPressed: () {
                    print(_controller);
                    _controller.back();
                  },
                  child:Icon(Icons.arrow_back_sharp,color:Colors.purpleAccent,size:55.0,)
              ) ,

              OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  onPressed: () {
                    _controller.forward();
                  },
                  child:Icon(Icons.arrow_forward,color:Colors.purpleAccent,size:55.0,)
              ),],
          ),
        ],
      ),
    );
  }
}