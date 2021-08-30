import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projem/home_page.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'dart:async';



final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:Color(0xfff3e5f5),
        body:SingleChildScrollView(
          child: Center(
            child:Column(
              children: [
                Row(
                  children: [
                    Container(
                      alignment:Alignment.bottomLeft,
                      margin:EdgeInsets.only(top:40.0,left:55.0,),
                      child:Image.network("https://image.flaticon.com/icons/png/512/2240/2240730.png",width:60.0,),
                      decoration:BoxDecoration(
                        //color:Color(0xfff9fbe7),
                          borderRadius:BorderRadius.circular(130.0)

                      ),),
                    Container(
                      alignment:Alignment.bottomLeft,
                      margin:EdgeInsets.only(top:80.0,right:45.0,left:180.0),
                      child:Image.network("https://image.flaticon.com/icons/png/512/740/740882.png",width:50.0,),
                      decoration:BoxDecoration(
                        //color:Color(0xfff9fbe7),
                          borderRadius:BorderRadius.circular(130.0)

                      ),),

                  ],
                ),
                Container(
                  margin:EdgeInsets.only(top:40.0),
                  width:200.0,
                  height:200.0,
                  decoration:BoxDecoration(
                      color:Color(0xfff9fbe7),
                      borderRadius:BorderRadius.circular(120.0)

                  ),
                  child:Container(
                      padding:EdgeInsets.all(29.0),
                      child: Image.network("https://image.flaticon.com/icons/png/512/817/817845.png",width:180.0,)),
                ),SizedBox(height:40.0,),

                Form(
                  key:_formKey,
                  child:Column(
                    children: [
                      Container(
                          alignment:Alignment.topLeft,
                          margin:EdgeInsets.only(left:48.0),
                          child: Text("E-Mail",style:GoogleFonts.breeSerif(color:Color(0xfff48fb1),fontSize:18.0),)),
                      SizedBox(height: 5.0,),
                      Container(
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              validator:(String? mail) {
                                if (mail!.trim().isEmpty) return "Mailinizi Giriniz";
                                return null;
                              },
                              cursorColor: Color(0xfff48fb1),
                              controller: _emailController,
                              decoration: const InputDecoration(
                                border:InputBorder.none,
                                // hintText: "E-Mail",
                                //hintStyle: TextStyle(fontSize: 20.0, color: Colors.redAccent),

                                focusedBorder: UnderlineInputBorder(
                                  borderSide:BorderSide(color: Colors.green),

                                ),),
                            ),

                          ),
                        ),
                        width:300.0,
                        height:50.0,
                        decoration:BoxDecoration(
                            color:Color(0xfff9fbe7),
                            borderRadius:BorderRadius.circular(10.0)

                        ),
                      ),
                      SizedBox(height:30.0,),
                      //buraya yapştır
                      Container(
                          alignment:Alignment.topLeft,
                          margin:EdgeInsets.only(left:48.0),
                          child: Text("Şifre",style:GoogleFonts.breeSerif(color:Color(0xfff48fb1),fontSize:18.0),)),
                      SizedBox(height: 5.0,),
                      Container(
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              validator: (String? password) {
                                if (password!.trim().isEmpty) return "Şifrenizi Giriniz";
                                if(password.length<6){
                                  return "Şifreniz en az 6 haneli olmalıdır";
                                }
                                return null;
                              },
                              obscureText:true,
                              cursorColor: Color(0xfff48fb1),
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                border:InputBorder.none,
                                // hintText: "E-Mail",
                                //hintStyle: TextStyle(fontSize: 20.0, color: Colors.redAccent),

                                focusedBorder: UnderlineInputBorder(
                                  borderSide:BorderSide(color: Colors.green),

                                ),),
                            ),

                          ),
                        ),
                        width:300.0,
                        height:50.0,
                        decoration:BoxDecoration(
                            color:Color(0xfff9fbe7),
                            borderRadius:BorderRadius.circular(10.0)

                        ),
                      ),



                    ],
                  ),


                ),

                SizedBox(height:30.0,),
                Container(
                  alignment:Alignment.center,
                  width:150.0,
                  height: 50.0,
                  decoration:BoxDecoration(
                      color:Color(0xfff9fbe7),
                      borderRadius:BorderRadius.circular(10.0)

                  ),
                  child:TextButton.icon(onPressed:()async {
                    if (_formKey.currentState!.validate()) {
                      _signIn(_emailController,_passwordController);
                    }
                  },
                    icon:Icon(Icons.email_rounded,color:Color(0xfff48fb1),size:22.0,),
                    label:Text("Giriş Yap",style:GoogleFonts.breeSerif(color:Color(0xfff48fb1),fontSize:20.0)),),
                ),SizedBox(height:30.0,),





              ],
            ),
          ),
        )




    );
  }
}
void _signIn(TextEditingController _emailController,TextEditingController _passwordController) async {
  try {
    final UserCredential userCredential =
    await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    final User? user = userCredential.user;

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Merhaba, ${user!.email}"),
      ),
    );

    void navigation() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }

    var _duration = Duration(seconds: 2);
    Timer(_duration, navigation);
  } on FirebaseAuthException catch (e) {
    if (e.message == 'The email address is badly formatted.') {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("E-mail adresi kötü bir formatta lütfen düzeltiniz."),

        ),
      );
    } else if (e.message == 'The password is invalid or the user does not have a password.') {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Bu e-maile ait şifre yanlış girilmiştir."),

        ),
      );
    }
    else if (e.message == 'There is no user record corresponding to this identifier. The user may have been deleted.') {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Bu e-mail ile kayıtlı kullanıcı bulunamadı."),

        ),
      );
    }
  } catch (e) {
    print(e.toString());
  }
}

