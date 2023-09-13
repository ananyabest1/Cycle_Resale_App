import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_attendance_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const String _title = 'Splash';
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 270, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.yellow,
          image: DecorationImage(
            image: NetworkImage("https://i.pinimg.com/originals/ef/e0/ff/efe0ffdb5b698ee71ed12c4e4be061fb.jpg"),
            fit: BoxFit.cover,
            opacity: 0.6,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("WELCOME" , style: GoogleFonts.lakkiReddy(
              fontSize: 75,
              color: Colors.black,
            ),),
            SizedBox( height: 30),
            Column(
              children: [
                Text("Punctuality is the politeness of kings",
                  style: GoogleFonts.lancelot(
                    fontSize: 30,
                    color: Colors.black,
                  ), ),
                SizedBox(height: 170),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15 , horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 65,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
