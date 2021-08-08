import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcard/tcard.dart';
class Sekiller extends StatefulWidget {
  const Sekiller({Key? key}) : super(key: key);

  @override
  _SekillerState createState() => _SekillerState();
}

class _SekillerState extends State<Sekiller> {
  TCardController _controller = TCardController();
  final List<String> imageList =[
    "https://image.flaticon.com/icons/png/512/1274/1274955.png",
    "https://image.flaticon.com/icons/png/512/1274/1274954.png",
    "https://image.flaticon.com/icons/png/512/594/594846.png",
    "https://image.flaticon.com/icons/png/512/1200/1200882.png",
    "https://image.flaticon.com/icons/png/512/645/645928.png",
    "https://image.flaticon.com/icons/png/512/616/616655.png",
    "https://image.flaticon.com/icons/png/512/650/650089.png",
    "https://image.flaticon.com/icons/png/512/650/650088.png",
    "https://image.flaticon.com/icons/png/512/650/650090.png",
    "https://image.flaticon.com/icons/png/512/3208/3208707.png"
  ];
  final List<String> sekilList =[
    "Square Kare","Pentagon Beşgen","Circle  Daire ","Triangle  Üçgen","Cube  Küp","Star  Yıldız","Oval  Oval",
    "Ractangle   Dikdörtgen","Hexagon  Altıgen","Heart  Kalp"

  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      sekilList.length,
          (int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
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
                Text(sekilList[index],
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
        backgroundColor: Colors.grey.shade400,
        title: Center(
          child: Text(
            'Haydi  Şekillere  Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),

      backgroundColor: Colors.grey.shade400,
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



