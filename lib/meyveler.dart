// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Meyveler extends StatefulWidget {
  @override
  _MeyvelerState createState() => _MeyvelerState();
}

class _MeyvelerState extends State<Meyveler> {
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

    pref.setInt('meyveIndexSave', test1);
    // pref.setInt('progress', progress.toInt());
    print('KAYDEDİLDİ' + test1.toString());
  }

  Future<void> readIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int test2 = pref.getInt('meyveIndexSave');
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
  final List<String> meyveEList =[
    "Grape",
    "Watermelon","Pear","Cherry","Banana","Apple","Orange",
    "Strawberry","Peach","Melon"
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        backgroundColor: Colors.pinkAccent.shade100,
        title: Center(
          child: Text(
            'Haydi Meyvelere Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 23.0, color: Colors.pink.shade400),
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
        color: Colors.pinkAccent.shade100,
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
                Text(meyveList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 34.0, color: Colors.pink.shade400)),
                FloatingActionButton(
                  backgroundColor: Colors.pink,
                  onPressed: (){
                    isSpeaking ? stop() : speak(meyveEList[index]);
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