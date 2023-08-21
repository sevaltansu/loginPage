import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final firebaseAuth = FirebaseAuth.instance;
  late String email, password;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF21254A),
      body: SingleChildScrollView(
        child: Center(
            child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * .25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/topImage.png'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText(),
                      customSizedBox(),
                      emailTextFormField(),
                      customSizedBox(),
                      sifreTextFormField(),
                      customSizedBox(),
                      signInButton(),
                      customSizedBox(),
                      forgotPasswordButton(),
                      customSizedBox(),
                      Center(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/signUp");
                              },
                              child: Text(
                                'Hesap Oluştur',
                                style: TextStyle(color: Colors.pink[200]),
                              ))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Center forgotPasswordButton() {
    return Center(
        child: TextButton(
            onPressed: () {},
            child: Text(
              'Şifremi Unuttum',
              style: TextStyle(color: Colors.pink[200]),
            )));
  }

  Center signInButton() {
    return Center(
      child: TextButton(
        onPressed: signIn,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xFF31274F)),
          height: 50,
          width: 150,
          child: Center(
            child: Text(
              'Giriş Yap',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        final userResult = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushReplacementNamed(context, "/homePage");
        print(userResult.user!.email);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: buildInputDecoration('Email'),
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz";
        } else {}
      },
      onSaved: (value) {
        email = value!;
      },
    );
  }

  TextFormField sifreTextFormField() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: buildInputDecoration('Şifre'),
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz";
        } else {}
      },
      onSaved: (value) {
        password = value!;
      },
    );
  }

  Text titleText() {
    return Text(
      'Merhaba,\nHoşgeldiniz',
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget customSizedBox() => SizedBox(
        height: 20,
      );

  InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      hintStyle: TextStyle(color: Colors.grey),
      hintText: hintText,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }
}
