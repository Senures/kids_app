// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Vucut extends StatefulWidget {
  @override
  _VucutState createState() => _VucutState();
}

class _VucutState extends State<Vucut> {
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

    pref.setInt('vucutIndexSave', test1);
    // pref.setInt('progress', progress.toInt());
    print('KAYDEDİLDİ' + test1.toString());
  }

  Future<void> readIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int test2 = pref.getInt('vucutIndexSave');
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
    "https://image.flaticon.com/icons/png/512/2824/2824779.png",
    "https://image.flaticon.com/icons/png/512/822/822103.png",
    "https://image.flaticon.com/icons/png/512/356/356220.png",
    "https://image.flaticon.com/icons/png/512/2688/2688313.png",
    "https://image.flaticon.com/icons/png/512/1471/1471735.png",
    "https://image.flaticon.com/icons/png/512/2165/2165920.png",
    "https://image.flaticon.com/icons/png/512/1471/1471729.png",
    "https://image.flaticon.com/icons/png/512/2721/2721001.png",
    "https://image.flaticon.com/icons/png/512/1612/1612781.png",
    "https://image.flaticon.com/icons/png/512/2867/2867348.png",
    "https://image.flaticon.com/icons/png/512/5018/5018299.png",
    "https://image.flaticon.com/icons/png/512/2904/2904385.png",
    "https://image.flaticon.com/icons/png/512/3465/3465258.png",
    "https://image.flaticon.com/icons/png/512/2904/2904454.png"
  ];
  final List<String> vucutList =[
    "Eye  Göz","Ear  Kulak","Head  Kafa","Nose  Burun","Mouth  Ağız","Hand  El","Teeth  Dişler",
    "Arm  Kol","Finger  Parmak","Leg  Bacak","Foot  Ayak","Knee  Diz","Hair  Saç","Elbow  Dirsek"
  ];
  final List<String> vucutEList =[
    "Eye","Ear","Head","Nose","Mouth","Hand","Teeth",
    "Arm","Finger","Leg","Foot","Knee","Hair","Elbow"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        backgroundColor: Colors.orange,
        title: Center(
          child: Text(
            'Haydi Vücudumuza Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 21.0, color: Colors.white70),
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
        color: Colors.orange,
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
                Text(vucutList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 34.0, color: Colors.white70)),
                FloatingActionButton(
                  backgroundColor: Colors.orangeAccent,
                  onPressed: (){
                    isSpeaking ? stop() : speak(vucutEList[index]);
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