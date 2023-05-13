import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_screen .dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
        child: Container(
        height: screenHeight,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
        Hero(
        tag: 'logo',
          child: Container(
            child: Image.network(
                'https://static.vecteezy.com/system/resources/previews/021/551/442/original/skills-users-avatar-yellow-neon-icon-transparent-background-yellow-neon-icon-on-dark-background-vector.jpg'),
            height: screenHeight * 0.4,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.center,
          onChanged: (value) {
            email = value;
          },
          decoration: const InputDecoration(
            hintText: "Enter your email",
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        TextField(
          obscureText: true,
          textAlign: TextAlign.center,
          onChanged: (value) {
            password = value;
          },
          decoration: InputDecoration(
            hintText: 'Enter your password.',
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.04,
        ),
        Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
    child: Material(
    color: Colors.yellow,
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    elevation: 5.0,
    child: MaterialButton(
    onPressed: () async {
    try {
    final user =
    await _auth.signInWithEmailAndPassword(
    email: email, password: password);
    if (user != null) {
    Navigator.pushNamed(context, HomeScreen.id);
    }
    } catch (e) {
    print(e);
    }
    },
    minWidth: 200.0,
    ),
    ),
        ),
        ],
        ),
        ),
    ),
    );
  }
}