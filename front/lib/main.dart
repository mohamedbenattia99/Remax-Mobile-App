import 'package:authentification/locator.dart';
import 'package:authentification/screens/affiliate/list_etapes.dart';
import 'package:authentification/screens/login.dart';
import 'package:authentification/screens/parent/sign_up.dart';
import 'package:authentification/screens/client/signup_client.dart';
import 'package:authentification/screens/welcome.dart';
import 'package:authentification/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  setupLocator();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final dynamic map = {
      "/home": (context) => WelcomeScreen(),
      "/login": (context) => LoginScreen(),
      "/ajout-filiale": (context) => SignUpScreen(),
      "/signup": (context) => SignUpClientScreen(),
      '/welcome': (context) => WelcomeScreen(),
      "/list_etapes": (context) => ItineraryApp(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: map,
      theme: ThemeData(
        canvasColor: Colors.white,
        fontFamily: "Poppins",
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.indigo));
    return Scaffold(
      body: Wrapper(),
    );
  }
}
