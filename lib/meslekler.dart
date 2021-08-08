
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcard/tcard.dart';

class Meslekler extends StatefulWidget {
  const Meslekler({Key? key}) : super(key: key);

  @override
  _MesleklerState createState() => _MesleklerState();
}

class _MesleklerState extends State<Meslekler> {
  TCardController _controller = TCardController();
  final List<String> imageList =[
    "https://image.flaticon.com/icons/png/512/387/387561.png",
    "https://image.flaticon.com/icons/png/512/1421/1421631.png",
    "https://image.flaticon.com/icons/png/512/3504/3504193.png",
    "https://image.flaticon.com/icons/png/512/4297/4297908.png",
    "https://image.flaticon.com/icons/png/512/2705/2705779.png",
    "https://image.flaticon.com/icons/png/512/1995/1995627.png",
    "https://image.flaticon.com/icons/png/512/2317/2317964.png",
    "https://image.flaticon.com/icons/png/512/2809/2809789.png",
    "https://image.flaticon.com/icons/png/512/2917/2917687.png",
    "https://image.flaticon.com/icons/png/512/3135/3135810.png",
    "https://image.flaticon.com/icons/png/512/2317/2317996.png",
    "https://image.flaticon.com/icons/png/512/3231/3231641.png",
    "https://image.flaticon.com/icons/png/512/2127/2127682.png",
    "https://image.flaticon.com/icons/png/512/1995/1995429.png",
    "https://image.flaticon.com/icons/png/512/2472/2472632.png",
    "https://image.flaticon.com/icons/png/512/2450/2450883.png",
    "https://image.flaticon.com/icons/png/512/2111/2111231.png",
    "https://image.flaticon.com/icons/png/512/3144/3144927.png",
    "https://image.flaticon.com/icons/png/512/3461/3461891.png",
    "https://image.flaticon.com/icons/png/512/609/609034.png",
  ];
  final List<String> meslekList =[
    "Doctor Doktor", "Farmer Çiftçi","Driver Şoför","Teacher Öğretmen","Postman Postacı","Writer Yazar","Dendist  Diş hekimi",
    "Veterinary Veteriner","Tailor Terzi","Student  Öğrenci","Singer Şarkıcı","Soldier Asker","Mechanic Tamirci","Lawyer Avukat",
    "Police Polis","Journalist Gazeteci", "Hairdresser Kuaför","Fireman İtfaiyeci","Engineer Mühendis","Architect  Mimar"
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      meslekList.length,
          (int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.lime,
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
                Text(meslekList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 28.0, color: Colors.red)),
              ],
            ),
          ),
        );
      },
    );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: Center(
          child: Text(
            'Haydi Mesleklere Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),

      backgroundColor: Colors.lime,
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
                  child:Icon(Icons.arrow_back_sharp,color:Colors.red,size:55.0,)
              ) ,

              OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  onPressed: () {
                    _controller.forward();
                  },
                  child:Icon(Icons.arrow_forward,color:Colors.red,size:55.0,)
              ),],
          ),
        ],
      ),
    );
  }
}
