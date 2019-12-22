import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/core/viewmodels/login_model.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginModel>(context);

    return Scaffold(
     appBar: AppBar(
        title: Text('Settings'),
        elevation: 1.0,
      ),

      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    model.signOutGoogle();
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.remove_circle),
                  title: Text('Log out'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}