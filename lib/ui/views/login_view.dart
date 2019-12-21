import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/core/models/status.dart';
import 'package:take_note/core/viewmodels/login_model.dart';
import 'package:take_note/ui/views/home_screen.dart';
import 'package:take_note/ui/widgets/loader.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginModel>(context);

    Size size = MediaQuery.of(context).size;
    double deviceHeight = size.height;
    double deviceWidth = size.width;

    Status status = Status.BUSY;

    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Icon(Icons.note, size: 100.0),

                Text("T A K E N O T E",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),

                SizedBox(
                  height: 30.0,
                ),


                SizedBox(
                  height: 30.0,
                ),

                GestureDetector(
                  onTap: () {
                   model.signInWithGoogle().whenComplete(
                     () {
                       Navigator.of(context).push(
                         MaterialPageRoute(builder: (context) {
                           return HomeScreen();
                         })
                       );
                     }
                   );
                  },
                  child: Container(
                    width: deviceWidth,
                    height: 50.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: Colors.grey
                        ),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("assets/images/google_logo.png", width: 20.0, height: 20.0,),
                          SizedBox(width: 10.0),
                          Text('Sign in with google')
                        ],
                      ),
                    
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
