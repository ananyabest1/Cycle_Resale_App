import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_attendance_app/screens/home_screen%20.dart';
import 'package:online_attendance_app/screens/login_screen.dart';
import 'package:online_attendance_app/screens/registration_screen.dart';
import 'package:online_attendance_app/screens/splash_screen.dart';


final _auth = FirebaseAuth.instance;
String loggedUser = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( OnlineAttendance());
}

class OnlineAttendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme : ThemeData(
        scaffoldBackgroundColor: Color(0xFF212325),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id : (context) => SplashScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        HomeScreen.id : (context) => HomeScreen(),


      },
    );
  }
}