import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcard/tcard.dart';

class Hayvanlar extends StatefulWidget {
  const Hayvanlar({Key? key}) : super(key: key);

  @override
  _HayvanlarState createState() => _HayvanlarState();
}

class _HayvanlarState extends State<Hayvanlar> {
  TCardController _controller = TCardController();
  final List<String> imageList =[
    "https://image.flaticon.com/icons/png/512/1998/1998627.png",
    "https://image.flaticon.com/icons/png/512/1818/1818405.png",
    "https://image.flaticon.com/icons/png/512/1303/1303474.png",
    "https://image.flaticon.com/icons/png/512/1998/1998679.png",
    "https://image.flaticon.com/icons/png/512/1469/1469040.png",
    "https://image.flaticon.com/icons/png/512/1998/1998654.png",
    "https://image.flaticon.com/icons/png/512/4490/4490695.png",
    "https://image.flaticon.com/icons/png/512/5066/5066454.png",
    "https://image.flaticon.com/icons/png/512/875/875011.png",
    "https://image.flaticon.com/icons/png/512/1998/1998713.png",
    "https://image.flaticon.com/icons/png/512/1447/1447876.png",
    "https://image.flaticon.com/icons/png/512/490/490123.png",
    "https://image.flaticon.com/icons/png/512/1998/1998721.png",
    "https://image.flaticon.com/icons/png/512/2395/2395785.png",
    "https://image.flaticon.com/icons/png/512/1183/1183760.png",
    "https://image.flaticon.com/icons/png/512/809/809052.png",
    "https://image.flaticon.com/icons/png/512/3066/3066598.png",
    "https://image.flaticon.com/icons/png/512/2600/2600600.png",
    "https://image.flaticon.com/icons/png/512/1864/1864499.png",
    "https://image.flaticon.com/icons/png/512/1998/1998610.png",

  ];
  final List<String> hayvanList =[
    "Dog   Köpek", "Cat   Kedi","Turtle  Kaplumbağa ","Horse  At","Rabbit   Tavşan","Frog   Kurbağa","Camel   Deve",
    "Butterfly  Kelebek","Fish   Balık","Lion  Aslan","Snake   Yılan","Elephant  Fil","Monkey  Maymun","Giraffe  Zürafa","Owl   Baykuş","Bee  Arı",
    "Crab   Yengeç","Sheep   Koyun","Chicken  Tavuk","Cow   İnek"
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      hayvanList.length,
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
                Text(hayvanList[index],
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
            'Haydi  Hayvanlara  Bakalım',
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