

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcard/tcard.dart';

class Harfler extends StatefulWidget {
  @override
  _HarflerState createState() => _HarflerState();
}

class _HarflerState extends State<Harfler> {
  TCardController _controller = TCardController();

  final List<String> imageList = [
    "https://image.flaticon.com/icons/png/512/5226/5226018.png",
    "https://image.flaticon.com/icons/png/512/5226/5226024.png",
    "https://image.flaticon.com/icons/png/512/5226/5226234.png",
    "https://image.flaticon.com/icons/png/512/5226/5226046.png",
    "https://image.flaticon.com/icons/png/512/5226/5226056.png",
    "https://image.flaticon.com/icons/png/512/5226/5226066.png",
    "https://image.flaticon.com/icons/png/512/5226/5226072.png",
    "https://image.flaticon.com/icons/png/512/5226/5226081.png",
    "https://image.flaticon.com/icons/png/512/5226/5226092.png",
    "https://image.flaticon.com/icons/png/512/5226/5226098.png",
    "https://image.flaticon.com/icons/png/512/5226/5226105.png",
    "https://image.flaticon.com/icons/png/512/5226/5226110.png",
    "https://image.flaticon.com/icons/png/512/5226/5226118.png",
    "https://image.flaticon.com/icons/png/512/5226/5226123.png",
    "https://image.flaticon.com/icons/png/512/5226/5226131.png",
    "https://image.flaticon.com/icons/png/512/5226/5226139.png",
    "https://image.flaticon.com/icons/png/512/5226/5226152.png",
    "https://image.flaticon.com/icons/png/512/5226/5226159.png",
    "https://image.flaticon.com/icons/png/512/5226/5226166.png",
    "https://image.flaticon.com/icons/png/512/5226/5226171.png",
    "https://image.flaticon.com/icons/png/512/5226/5226178.png",
    "https://image.flaticon.com/icons/png/512/5226/5226184.png",
    "https://image.flaticon.com/icons/png/512/5226/5226192.png",
    "https://image.flaticon.com/icons/png/512/5226/5226201.png",
    "https://image.flaticon.com/icons/png/512/5226/5226210.png",
  ];
  final List<String> alfabeList = [
    "Armchair  Koltuk", "Bag  Çanta", "Carpet  Halı ", "Door  Kapı", "Eraser  Silgi", "Flower  Çiçek",
    "Glass  Bardak", "Home  Ev", "Iron  Ütü", "Jacket  Ceket", "Key  Anahtar", "Lamp  Lamba", "Mirror   Ayna",
    "Newspaper   Gazete", "Oven   Fırın", "Pencil  Kalem", "Radio   Radyo", "Scarf  Atkı", "Table   Masa", "Umpire  Hakem",
    "Violin   Keman", "Watch  Saat", "Xerox   Fotokopi", "Young   Genç", "Zipper   Fermuar"
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      alfabeList.length,
          (int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.amber.shade200,
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
                Text(alfabeList[index],
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
        backgroundColor: Colors.amber.shade200,
        title: Center(
          child: Text(
            'Haydi  Harflere  Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 20.0, color: Colors.purpleAccent),
          ),
        ),
      ),

      backgroundColor: Colors.amber.shade200,
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


