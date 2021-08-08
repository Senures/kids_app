import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcard/tcard.dart';
class Vucut extends StatefulWidget {
  const Vucut({Key? key}) : super(key: key);

  @override
  _VucutState createState() => _VucutState();
}

class _VucutState extends State<Vucut> {
  TCardController _controller = TCardController();

  final List<String> imageList =[
    "https://image.flaticon.com/icons/png/512/2824/2824779.png",
    "https://image.flaticon.com/icons/png/512/822/822103.png",
    "https://image.flaticon.com/icons/png/512/356/356220.png",
    "https://image.flaticon.com/icons/png/512/2688/2688313.png",
    "https://image.flaticon.com/icons/png/512/1471/1471735.png",
    "https://image.flaticon.com/icons/png/512/2165/2165920.png",
    "https://image.flaticon.com/icons/png/512/1471/1471729.png",
    "https://image.flaticon.com/icons/png/512/2721/2721001.png",
    "https://image.flaticon.com/icons/png/512/1612/1612781.png",
    "https://image.flaticon.com/icons/png/512/2867/2867348.png",
    "https://image.flaticon.com/icons/png/512/5018/5018299.png",
    "https://image.flaticon.com/icons/png/512/2904/2904385.png",
    "https://image.flaticon.com/icons/png/512/3465/3465258.png",
    "https://image.flaticon.com/icons/png/512/2904/2904454.png"
  ];
  final List<String> vucutList =[
    "Eye  Göz","Ear  Kulak","Head  Kafa","Nose  Burun","Mouth  Ağız","Hand  El","Teeth  Dişler",
    "Arm  Kol","Finger  Parmak","Leg  Bacak","Foot  Ayak","Knee  Diz","Hair  Saç","Elbow  Dirsek"
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      vucutList.length,
          (int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.orange,
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
                Text(vucutList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 28.0, color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(
          child: Text(
            'Haydi  Organlarımıza   Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),

      backgroundColor: Colors.orange,
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
                  child:Icon(Icons.arrow_back_sharp,color:Colors.white,size:55.0,)
              ) ,

              OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  onPressed: () {
                    _controller.forward();
                  },
                  child:Icon(Icons.arrow_forward,color:Colors.white,size:55.0,)
              ),],
          ),
        ],
      ),
    );
  }
}
