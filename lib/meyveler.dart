import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcard/tcard.dart';

class Meyveler extends StatefulWidget {

  const Meyveler({Key? key}) : super(key: key);

  @override
  _MeyvelerState createState() => _MeyvelerState();
}

class _MeyvelerState extends State<Meyveler> {
  TCardController _controller = TCardController();

  final List<String> imageList =[
    "https://image.flaticon.com/icons/png/512/1412/1412542.png",
    "https://image.flaticon.com/icons/png/512/4055/4055254.png",
    "https://image.flaticon.com/icons/png/512/415/415767.png",
    "https://image.flaticon.com/icons/png/512/135/135695.png",
    "https://image.flaticon.com/icons/png/512/2909/2909808.png",
    "https://image.flaticon.com/icons/png/512/415/415733.png",
    "https://image.flaticon.com/icons/png/512/1041/1041383.png",
    "https://image.flaticon.com/icons/png/512/4264/4264771.png",
    "https://image.flaticon.com/icons/png/512/4055/4055218.png",
    "https://image.flaticon.com/icons/png/512/1919/1919507.png"
  ];
  final List<String> meyveList =[
    "Grape  Üzüm",
    "Watermelon  Karpuz","Pear  Armut ","Cherry  Kiraz","Banana  Muz","Apple  Elma","Orange  Portakal",
    "Strawberry   Çilek","Peach  Şeftali","Melon   Kavun"

  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      meyveList.length,
          (int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
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
                Text(meyveList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 28.0, color: Colors.amber.shade200)),
              ],
            ),
          ),
        );
      },
    );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Center(
          child: Text(
            'Haydi  Meyvelere  Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 20.0, color: Colors.amber.shade200),
          ),
        ),
      ),

      backgroundColor: Colors.purpleAccent,
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
                  child:Icon(Icons.arrow_back_sharp,color:Colors.amber.shade200,size:55.0,)
              ) ,

              OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  onPressed: () {
                    _controller.forward();
                  },
                  child:Icon(Icons.arrow_forward,color:Colors.amber.shade200,size:55.0,)
              ),],
          ),
        ],
      ),
    );
  }
}