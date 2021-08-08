import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projem/home_page.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'dart:async';
import 'package:projem/verify.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Yap"),
        backgroundColor: Colors.green,
      ),
      body: _SignInBody(),
    );
  }
}

class _SignInBody extends StatefulWidget {
  @override
  __SignInBodyState createState() => __SignInBodyState();
}

class __SignInBodyState extends State<_SignInBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          //? Email / Şifre ile giriş
          _EmailPasswordForm(),
        ],
      ),
    );
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  __EmailPasswordFormState createState() => __EmailPasswordFormState();
}

class __EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        margin: const EdgeInsets.only(top: 85.0),
        child: Padding(
          padding: const EdgeInsets.all(55.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //? E-Mail
              TextFormField(
                cursorColor: Colors.green,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "E-Mail",
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                validator: (String? mail) {
                  if (mail!.trim().isEmpty) return "Mailinizi Giriniz";
                  return null;
                },
              ),
              //? Şifre
              TextFormField(
                cursorColor: Colors.green,
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Şifre",
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                validator: (String? password) {
                  if (password!.trim().isEmpty) return "Şifrenizi Giriniz";
                  return null;
                },
                obscureText: true, //! Şifrenin görünmesini engeller.
              ),
              Container(
                padding: const EdgeInsets.only(top: 35.0),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                  backgroundColor: Colors.green,
                  text: 'Giriş Yap',
                  icon: Icons.email,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _signIn();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
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
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("${e.message}"),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}

class _SignInProvider extends StatefulWidget {
  final String infoText;
  final Buttons buttonType;
  final Function signInMethod;

  const _SignInProvider({
    Key? key,
    required this.infoText,
    required this.buttonType,
    required this.signInMethod,
  }) : super(key: key);

  @override
  __SignInProviderState createState() => __SignInProviderState();
}

class __SignInProviderState extends State<_SignInProvider> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(55.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                widget.infoText,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              alignment: Alignment.center,
              child: SignInButton(
                widget.buttonType,
                text: widget.infoText,
                onPressed: () async => widget.signInMethod(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}