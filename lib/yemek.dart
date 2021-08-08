import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcard/tcard.dart';
class Yemek extends StatefulWidget {
  const Yemek({Key? key}) : super(key: key);

  @override
  _YemekState createState() => _YemekState();
}

class _YemekState extends State<Yemek> {
  TCardController _controller = TCardController();
  final List<String> imageList =[
    "https://image.flaticon.com/icons/png/512/3348/3348078.png",
    "https://image.flaticon.com/icons/png/512/684/684626.png",
    "https://image.flaticon.com/icons/png/512/2437/2437763.png",
    "https://image.flaticon.com/icons/png/512/2935/2935394.png",
    "https://image.flaticon.com/icons/png/512/4142/4142995.png",
    "https://image.flaticon.com/icons/png/512/1071/1071146.png",
    "https://image.flaticon.com/icons/png/512/2234/2234830.png",
    "https://image.flaticon.com/icons/png/512/2405/2405525.png",
    "https://image.flaticon.com/icons/png/512/1404/1404945.png",
    "https://image.flaticon.com/icons/png/512/791/791584.png",
    "https://image.flaticon.com/icons/png/512/1000/1000143.png",
    "https://image.flaticon.com/icons/png/512/911/911024.png",
    "https://image.flaticon.com/icons/png/512/736/736882.png",
    "https://image.flaticon.com/icons/png/512/3753/3753480.png",
    "https://image.flaticon.com/icons/png/512/2362/2362341.png",
    "https://image.flaticon.com/icons/png/512/2935/2935307.png",
    "https://image.flaticon.com/icons/png/512/3077/3077188.png",
    "https://image.flaticon.com/icons/png/512/448/448003.png",

  ];
  final List<String> yemekList =[
    "Bread  Ekmek","Water  Su","Egg  Yumurta ","Milk  Süt","Chocolate  Çikolata","Cheese  Peynir","Honey  Bal",
    "Tea  Çay","Pizza  Pizza","Soap  Çorba"," Sausage  Sosis","Lemonade  Limonata"," Salt  Tuz","Cookie  Kurabiye",
    "Ketchup   Ketçap"," Coffee   Kahve", "Ice-cream  Dondurma" ," Cake  Pasta"
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      yemekList.length,
          (int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
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
                Text(yemekList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 28.0, color: Colors.pinkAccent)),
              ],
            ),
          ),
        );
      },
    );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(
          child: Text(
            'Haydi  Yiyeceklere  Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 20.0, color: Colors.pinkAccent),
          ),
        ),
      ),

      backgroundColor: Colors.yellow,
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
                  child:Icon(Icons.arrow_back_sharp,color:Colors.pinkAccent,size:55.0,)
              ) ,

              OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  onPressed: () {
                    _controller.forward();
                  },
                  child:Icon(Icons.arrow_forward,color:Colors.pinkAccent,size:55.0,)
              ),],
          ),
        ],
      ),
    );
  }
}


