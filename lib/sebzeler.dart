// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sebzeler extends StatefulWidget {
  @override
  _SebzelerState createState() => _SebzelerState();
}

class _SebzelerState extends State<Sebzeler> {
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

    pref.setInt('sebzeIndexSave', test1);
    // pref.setInt('progress', progress.toInt());
    print('KAYDEDİLDİ' + test1.toString());
  }

  Future<void> readIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int test2 = pref.getInt('sebzeIndexSave');
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
    "https://image.flaticon.com/icons/png/512/1041/1041355.png",
    "https://image.flaticon.com/icons/png/512/4264/4264743.png",
    "https://image.flaticon.com/icons/png/512/1147/1147593.png",
    "https://image.flaticon.com/icons/png/512/1147/1147561.png",
    "https://image.flaticon.com/icons/png/512/424/424223.png",
    "https://image.flaticon.com/icons/png/512/2909/2909841.png",
    "https://image.flaticon.com/icons/png/512/4056/4056833.png",
    "https://image.flaticon.com/icons/png/512/4264/4264598.png",
    "https://image.flaticon.com/icons/png/512/2346/2346905.png",
    "https://image.flaticon.com/icons/png/512/1147/1147609.png"
  ];
  final List<String> sebzeList =[
    "Carrot  Havuç",
    "Tomato  Domates","Corn  Mısır","Eggplant  Patlıcan","Onion  Soğan","Broccoli  Brokoli","Pepper  Biber",
    "Lemon  Limon","Cucumber  Salatalık","Mushroom  Mantar"

  ];
  final List<String> sebzeEList =[
    "Carrot",
    "Tomato","Corn","Eggplant","Onion","Broccoli","Pepper",
    "Lemon","Cucumber","Mushroom"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        backgroundColor: Colors.orange.shade100,
        title: Center(
          child: Text(
            'Haydi Sebzelere Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 23.0, color: Colors.orange),
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
        color: Colors.orange.shade100,
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
                Text(sebzeList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 34.0, color: Colors.orange)),
                FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  onPressed: (){
                    isSpeaking ? stop() : speak(sebzeEList[index]);
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
