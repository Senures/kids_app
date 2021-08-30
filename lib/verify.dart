import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projem/signin_page.dart';


class VerifyScreen extends StatefulWidget {
	@override
	_VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
	final auth = FirebaseAuth.instance;
	late User user;
	late Timer timer;

	@override
	void initState() {
		user = auth.currentUser!;
		user.sendEmailVerification();

		timer = Timer.periodic(Duration(seconds:2), (timer) {
			checkEmailVerified();
		});
		super.initState();
	}

	@override
	void dispose() {
		timer.cancel();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
				backgroundColor:Color(0xffdcedc8),
			  body:Center(
					child: Column(
						children: [
							Row(
								children: [
									Expanded(
										child: Container(
												margin:EdgeInsets.all(50.0),
												alignment:Alignment.topLeft,
												child: Image.asset("resimler/verify1.png",width:100.0,)),
									),
									Expanded(
										child: Container(
												margin:EdgeInsets.only(top: 90.0,right:40.0),
												alignment:Alignment.topRight,
												child: Image.asset("resimler/verify1.png",width:100.0,)),
									),
								],
							),

							Padding(padding: EdgeInsets.only(top:50.0)),
							Image.asset("resimler/verify2.png",width:175.0,),
							SizedBox(height:90.0,),
							Container(

								alignment:Alignment.center,
								width:250.0,
								height:200.0,
								decoration:BoxDecoration(
									borderRadius:BorderRadius.circular(30.0),
									color:Color(0xffefebe9),
								),
								child:Padding(
									padding: const EdgeInsets.all(20.0),
									child: Column(
										children: [
											//Icon(Icons.mail_outline_sharp,color:Color(0xfff8bbd0),size:40.0,),
											Center(child: Padding(
												padding: const EdgeInsets.all(10.0),
												child: Text("Adresine bir e-posta gönderildi, ${user.email} lütfen doğrulayın.",style:GoogleFonts.robotoSlab(fontSize:19.0,color:Color(0xffbcaaa4))),
											)),
										],
									),
								),

							),
						],
					),
				),
		);
	}

	Future<void> checkEmailVerified() async {
		user = auth.currentUser!;
		await user.reload();
		if (user.emailVerified) {
			timer.cancel();
			Navigator.of(context).pushReplacement(
					MaterialPageRoute(builder: (context) => SignInPage()));
		}
	}
}