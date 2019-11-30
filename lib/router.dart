import 'package:flutter/material.dart';
import 'package:take_note/screens/cloud_view.dart';
import 'package:take_note/screens/editor.dart';
import 'package:take_note/screens/home_screen.dart';
import 'package:take_note/screens/splash_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return  MaterialPageRoute(
          builder: (_)=> SplashScreen()
        );
     
      case '/cloud' :
        return MaterialPageRoute(
            builder: (_)=> CloudView()
        ) ;
         case '/home' :
        return MaterialPageRoute(
            builder: (_)=> HomeScreen()
        ) ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}