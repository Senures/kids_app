// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tasit extends StatefulWidget {
  @override
  _TasitState createState() => _TasitState();
}

class _TasitState extends State<Tasit> {
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

    pref.setInt('tasitIndexSave', test1);
    // pref.setInt('progress', progress.toInt());
    print('KAYDEDİLDİ' + test1.toString());
  }

  Future<void> readIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int test2 = pref.getInt('tasitIndexSave');
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
  final List<String> tasitEList =[
    "Plane","Bus","Taxi","Car","Ship","Helicopter",
    "Motorbike","Subway","Train","Truck","Bycle","Tractor","Tram"
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        backgroundColor: Colors.indigo.shade400,
        title: Center(
          child: Text(
            'Haydi Taşıtlara Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 23.0, color: Colors.blue.shade100),
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
        color: Colors.indigo.shade400,
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
                Text(tasitList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 34.0, color: Colors.blue.shade100)),
                FloatingActionButton(
                  backgroundColor: Colors.blue.shade200,
                  onPressed: (){
                    isSpeaking ? stop() : speak(tasitEList[index]);
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