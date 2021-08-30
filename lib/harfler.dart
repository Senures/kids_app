// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Harfler extends StatefulWidget {
  @override
  _HarflerState createState() => _HarflerState();
}

class _HarflerState extends State<Harfler> {

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

    pref.setInt('testIndexSave', test1);
    // pref.setInt('progress', progress.toInt());
    print('KAYDEDİLDİ' + test1.toString());
  }

  Future<void> readIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int test2 = pref.getInt('testIndexSave');
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
    "Armchair  Koltuk",
    "Bag  Çanta",
    "Carpet  Halı ",
    "Door  Kapı",
    "Eraser  Silgi",
    "Flower  Çiçek",
    "Glass  Bardak",
    "Home  Ev",
    "Iron  Ütü",
    "Jacket  Ceket",
    "Key  Anahtar",
    "Lamp  Lamba",
    "Mirror   Ayna",
    "Newspaper   Gazete",
    "Oven   Fırın",
    "Pencil  Kalem",
    "Radio   Radyo",
    "Scarf  Atkı",
    "Table   Masa",
    "Umpire  Hakem",
    "Violin   Keman",
    "Watch  Saat",
    "Xerox   Fotokopi",
    "Young   Genç",
    "Zipper   Fermuar"
  ];
  final List<String> alfabeEList = [
    "Armchair",
    "Bag",
    "Carpet",
    "Door",
    "Eraser",
    "Flower",
    "Glass",
    "Home",
    "Iron",
    "Jacket",
    "Key",
    "Lamp",
    "Mirror",
    "Newspaper",
    "Oven",
    "Pencil",
    "Radio",
    "Scarf",
    "Table",
    "Umpire",
    "Violin",
    "Watch",
    "Xerox",
    "Young",
    "Zipper"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        backgroundColor: Colors.amber.shade200,
        title: Center(
          child: Text(
            'Haydi  Harflere  Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 23.0, color: Colors.purpleAccent),
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
        color: Colors.amber.shade200,
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
                Text(alfabeList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 34.0, color: Colors.purpleAccent)),
                FloatingActionButton(
                  backgroundColor: Colors.orangeAccent,
                  onPressed: (){
                    isSpeaking ? stop() : speak(alfabeEList[index]);
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
