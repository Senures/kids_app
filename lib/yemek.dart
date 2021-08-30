// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Yemek extends StatefulWidget {
  @override
  _YemekState createState() => _YemekState();
}

class _YemekState extends State<Yemek> {
  bool isSpeaking = false;
  final _flutterTts = FlutterTts();

  void initializeTts() {
    _flutterTts.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });
    _flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
    _flutterTts.setErrorHandler((message) {
      setState(() {
        isSpeaking = false;
      });
    });
    _flutterTts.setVolume(1.0);
    _flutterTts.setSpeechRate(0.3);
  }
  void speak(String a) async {
    if (a.isNotEmpty) {//liste boş değilse
      await _flutterTts.speak(a.toString());//burda listeyi konuşturuyor
    }
  }

  void stop() async {
    await _flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }


  PageController pageController;
  bool loading = false;

  @override
  initState() {
    super.initState();
    getData();
    initializeTts();

  }

  Future<void> getData() async {
    setState(() {
      loading = true;
    });
    readIndex();
  }

  Future<void> saveIndex(int value) async {
    int test1 = value;
    //double progress = (25/value)*100;
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setInt('yemekIndexSave', test1);
    // pref.setInt('progress', progress.toInt());
    print('KAYDEDİLDİ' + test1.toString());
  }

  Future<void> readIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int test2 = pref.getInt('yemekIndexSave');
    print('KAYDEDİLEN' + test2.toString());

    if (test2 != null) {
      setState(() {
        loading = false;
        pageController = PageController(initialPage: test2);
      });
    } else {
      setState(() {
        loading = false;
        pageController = PageController(initialPage: 0);
      });
    }
  }

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
  final List<String> yemekEList =[
    "Bread","Water","Egg ","Milk","Chocolate","Cheese","Honey",
    "Tea","Pizza","Soap"," Sausage","Lemonade"," Salt","Cookie",
    "Ketchup"," Coffee", "Ice-cream" ," Cake"
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        backgroundColor: Colors.yellow,
        title: Center(
          child: Text(
            'Haydi Yiyeceklere Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 23.0, color: Colors.pinkAccent),
          ),
        ),
      ),
      body: loading == true
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        height: size.height,
        width: size.width,
        color: Colors.yellow,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageList.length,
          pageSnapping: true,
          controller: pageController,
          onPageChanged: (value) {
            saveIndex(value);
          },
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,),
                  child: Container(
                    padding:EdgeInsets.all(30.0),
                    decoration:BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30),
                        )
                    ),

                    width:340.0,
                    height:340.0,
                    child: Image.network(
                      imageList[index],
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
                Text(yemekList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 34.0, color: Colors.pinkAccent)),
                FloatingActionButton(
                  backgroundColor: Colors.pink,
                  onPressed: (){
                    isSpeaking ? stop() : speak(yemekEList[index]);
                    debugPrint("Butona tıklandı");
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  tooltip: 'SES',
                  child: Icon(Icons.music_note_rounded),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}


