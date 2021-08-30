// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Hayvanlar extends StatefulWidget {
  @override
  _HayvanlarState createState() => _HayvanlarState();
}

class _HayvanlarState extends State<Hayvanlar> {
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

    pref.setInt('hayvanIndexSave', test1);
    // pref.setInt('progress', progress.toInt());
    print('KAYDEDİLDİ' + test1.toString());
  }

  Future<void> readIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int test2 = pref.getInt('hayvanIndexSave');
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
  final List<String> hayvanEList =[
    "Dog", "Cat","Turtle","Horse","Rabbit","Frog","Camel",
    "Butterfly","Fish","Lion","Snake","Elephant","Monkey","Giraffe","Owl","Bee",
    "Crab","Sheep","Chicken","Cow"
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
            'Haydi Hayvanlara Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 23.0, color: Colors.purple),
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
                Text(hayvanList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 34.0, color: Colors.purple)),
                FloatingActionButton(
                  backgroundColor: Colors.purpleAccent,
                  onPressed: (){
                    isSpeaking ? stop() : speak(hayvanEList[index]);
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