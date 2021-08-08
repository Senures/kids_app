import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcard/tcard.dart';

class Sebzeler extends StatefulWidget {
  const Sebzeler({Key? key}) : super(key: key);

  @override
  _SebzelerState createState() => _SebzelerState();
}

class _SebzelerState extends State<Sebzeler> {
  TCardController _controller = TCardController();

  final List<String> imageList =[
    "https://image.flaticon.com/icons/png/512/1041/1041355.png",
    "https://image.flaticon.com/icons/png/512/4264/4264743.png",
    "https://image.flaticon.com/icons/png/512/1147/1147593.png",
    "https://image.flaticon.com/icons/png/512/1147/1147561.png",
    "https://image.flaticon.com/icons/png/512/424/424223.png",
    "https://image.flaticon.com/icons/png/512/2909/2909841.png",
    "https://image.flaticon.com/icons/png/512/4056/4056833.png",
    "https://image.flaticon.com/icons/png/512/4264/4264598.png",
    "https://image.flaticon.com/icons/png/512/2346/2346905.png",
    "https://image.flaticon.com/icons/png/512/1147/1147609.png"
  ];
  final List<String> sebzeList =[
    "Carrot  Havuç",
    "Tomato  Domates","Corn  Mısır","Eggplant  Patlıcan","Onion  Soğan","Broccoli  Brokoli","Pepper  Biber",
    "Lemon  Limon","Cucumber  Salatalık","Mushroom  Mantar"

  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      sebzeList.length,
          (int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
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
                Text(sebzeList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 28.0, color: Colors.orange)),
              ],
            ),
          ),
        );
      },
    );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade100,
        title: Center(
          child: Text(
            'Haydi  Sebzelere  Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 20.0, color: Colors.orange),
          ),
        ),
      ),

      backgroundColor: Colors.orange.shade100,
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
                  child:Icon(Icons.arrow_back_sharp,color:Colors.orange,size:55.0,)
              ) ,

              OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  onPressed: () {
                    _controller.forward();
                  },
                  child:Icon(Icons.arrow_forward,color:Colors.orange,size:55.0,)
              ),],
          ),
        ],
      ),
    );
  }
}


