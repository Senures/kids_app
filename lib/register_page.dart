import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projem/verify.dart';
import 'package:projem/home_page.dart';

/// Email / Şifre ile kayıt sayfası
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _ageController = TextEditingController();


  bool _success = true;
  late String _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Kayıt Ol"),
      ),
      body:Form(
        key: _formKey,
        child: Card(

          margin: const EdgeInsets.only(top: 85.0),
          child: Padding(
            padding: const EdgeInsets.all(55.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //? E-Mail
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "E-Mail",
                      labelStyle: TextStyle(color: Colors.purple),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                    validator: (String? mail) {
                      if (mail!.isEmpty) {
                        return "Mailinizi Giriniz";
                      }
                      return null;
                    },
                  ),
                  //? Şifre
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: "Şifre",
                      labelStyle: TextStyle(color: Colors.purple),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                    validator: (String? password) {
                      if (password!.isEmpty) {
                        return "Şifrenizi Giriniz";
                      }
                      return null;
                    },
                    obscureText: true, //! Şifrenin görünmesini engeller.
                  ),
                  TextFormField(
                    controller: _displayName,
                    decoration: const InputDecoration(
                        labelText: 'Ad Soyad',
                        labelStyle: TextStyle(color: Colors.purple),
                       focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Lütfen adınızı giriniz';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: 'Yaş',
                      labelStyle: TextStyle(color: Colors.purple),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Lütfen yaş giriniz';
                      }
                      return null;
                    },
                  ),

                  //? Kayıt ol buttonu
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 35.0),
                    alignment: Alignment.center,
                    child: SignInButtonBuilder(
                      icon: Icons.person_add,
                      backgroundColor: Colors.purple,
                      onPressed: () async {if (_formKey.currentState!.validate()) {
                        _register();
                      }
                      },
                      text: "Kayıt ol",
                    ),
                  ),
                  //? Geri bildirim

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    //! Widget kapatıldığında controllerları temizle
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    try {

      final User? user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyScreen(),
        ),
      );
      if (user != null) {
        setState(() {
          _success = true;
          _message = "Kayıt başarılı ${user.email}";
        });
      } else {
        setState(() {
          _success = false;
          _message = "Kayıt başarısız.";
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _success = false;
        _message = "Kayıt başarısız.\n\n$e";
      });
    }
  }
}