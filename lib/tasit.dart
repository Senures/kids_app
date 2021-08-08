import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcard/tcard.dart';
class Tasit extends StatefulWidget {
  const Tasit({Key? key}) : super(key: key);

  @override
  _TasitState createState() => _TasitState();
}

class _TasitState extends State<Tasit> {
  TCardController _controller = TCardController();

  final List<String> imageList =[
    "https://image.flaticon.com/icons/png/512/3324/3324507.png",
    "https://image.flaticon.com/icons/png/512/808/808375.png",
    "https://image.flaticon.com/icons/png/512/168/168260.png",
    "https://image.flaticon.com/icons/png/512/741/741407.png",
    "https://image.flaticon.com/icons/png/512/3205/3205218.png",
    "https://image.flaticon.com/icons/png/512/2709/2709392.png",
    "https://image.flaticon.com/icons/png/512/296/296210.png",
    "https://image.flaticon.com/icons/png/512/4736/4736310.png",
    "https://image.flaticon.com/icons/png/512/936/936634.png",
    "https://image.flaticon.com/icons/png/512/713/713311.png",
    "https://image.flaticon.com/icons/png/512/983/983534.png",
    "https://image.flaticon.com/icons/png/512/146/146748.png",
    "https://image.flaticon.com/icons/png/512/1008/1008107.png",
  ];
  final List<String> tasitList =[
    "Plane  Uçak","Bus  Otobüs","Taxi  Taksi","Car  Araba","Ship  Gemi","Helicopter Helikopter",
    "Motorbike  Motorsiklet","Subway  Metro","Train  Tren","Truck  Kamyon","Bycle   Bisiklet","Tractor  Traktör","Tram  Tramvay"
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      tasitList.length,
          (int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.indigo.shade400,
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
                Text(tasitList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 28.0, color: Colors.blue.shade100)),
              ],
            ),
          ),
        );
      },
    );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: Center(
          child: Text(
            'Haydi  Taşıtlara  Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 20.0, color: Colors.blue.shade100),
          ),
        ),
      ),

      backgroundColor: Colors.indigo.shade400,
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
                  child:Icon(Icons.arrow_back_sharp,color:Colors.blue.shade100,size:55.0,)
              ) ,

              OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  onPressed: () {
                    _controller.forward();
                  },
                  child:Icon(Icons.arrow_forward,color:Colors.blue.shade100,size:55.0,)
              ),],
          ),
        ],
      ),
    );
  }
}
