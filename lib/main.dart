import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/core/viewmodels/cloud_model.dart';
import 'package:take_note/core/viewmodels/documents_model.dart';
import 'package:take_note/core/viewmodels/login_model.dart';
import 'package:take_note/locator.dart';
import 'package:take_note/router.dart';
import 'package:take_note/ui/views/home_screen.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:take_note/ui/views/splash_screen.dart';


void main() {
  setupLocator();
  Admob.initialize('ca-app-pub-7063490524190385~2657996272');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<CloudModel>(),),
        ChangeNotifierProvider(builder: (_) => locator<DocumentModel>(),),
        ChangeNotifierProvider(builder: (_) => locator<LoginModel>(),)
      ],
          child: DynamicTheme(
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
            title: 'Take Note',
            theme: theme,
            initialRoute: '/',
            onGenerateRoute: Router.generateRoute,
          );
        },
      ),
    );
  }
}
