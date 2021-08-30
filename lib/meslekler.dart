// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Meslekler extends StatefulWidget {
  @override
  _MesleklerState createState() => _MesleklerState();
}

class _MesleklerState extends State<Meslekler> {
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

    pref.setInt('meslekIndexSave', test1);
    // pref.setInt('progress', progress.toInt());
    print('KAYDEDİLDİ' + test1.toString());
  }

  Future<void> readIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int test2 = pref.getInt('meslekIndexSave');
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
  final List<String> meslekEList =[
    "Doctor", "Farmer","Driver","Teacher","Postman","Writer","Dendist",
    "Veterinary","Tailor","Student","Singer","Soldier","Mechanic","Lawyer",
    "Police","Journalist", "Hairdresser","Fireman","Engineer","Architect"
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        backgroundColor: Colors.lime,
        title: Center(
          child: Text(
            'Haydi Mesleklere Bakalım',
            style: GoogleFonts.robotoSlab(
                fontSize: 23.0, color: Colors.red),
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
        color: Colors.lime,
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
                Text(meslekList[index],
                    style: GoogleFonts.robotoSlab(
                        fontSize: 34.0, color: Colors.red)),
                FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  onPressed: (){
                    isSpeaking ? stop() : speak(meslekEList[index]);
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