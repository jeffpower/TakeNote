import 'dart:async';

import 'package:flutter/material.dart';
import 'package:take_note/ui/views/home_screen.dart';
import 'package:take_note/ui/views/login_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return LoginScreen();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.note, size: 100.0),
              SizedBox(height: 20.0,),
              Text("T A K E N O T E", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
