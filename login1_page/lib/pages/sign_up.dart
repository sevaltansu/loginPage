import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                    signUpButtton(),
                    customSizedBox(),
                    backToLoginPage(context),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Center backToLoginPage(BuildContext context) {
    return Center(
        child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/loginPage");
            },
            child: Text(
              'Giriş Sayfasına Geri Dön',
              style: TextStyle(color: Colors.pink[200]),
            )));
  }

  Center signUpButtton() {
    return Center(
        child: TextButton(
            onPressed: signIn,
            child: Text(
              'Hesap Oluştur',
              style: TextStyle(color: Colors.pink[200]),
            )));
  }

  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        var userResult = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Hesabınız Oluşturuldu,Giriş Sayfasına Yönlendiriliyorsunuz"),
          ),
        );
        Navigator.pushReplacementNamed(context, "/loginPage");
      } catch (e) {
        print(e.toString());
      }
    } else {}
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
