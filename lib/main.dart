import 'package:flutter/material.dart';
import 'package:take_note/screens/home_screen.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:take_note/screens/splash_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
          primarySwatch: Colors.blue,
          brightness: brightness,
          fontFamily: 'MuseoSans',
          appBarTheme: AppBarTheme(
              color:
                  brightness == Brightness.dark ? Colors.black12 : Colors.white,
              brightness: brightness,
              textTheme: TextTheme(
                  title: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20.0)),
              iconTheme: IconThemeData(
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black)),
          iconTheme: IconThemeData(
              color:
                  brightness == Brightness.dark ? Colors.white : Colors.black),
          // backgroundColor: brightness == Brightness.dark ? Colors.white : Colors.black26
                  
          ),
          
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme,
          home: SplashScreen(),
        );
      },
    );
  }
}
