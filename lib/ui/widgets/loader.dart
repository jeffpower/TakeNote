import 'package:flutter/material.dart';


class Loader extends StatelessWidget {
  
  Loader({Key key, this.opacity = 1.0}) : super(key: key);

  final double opacity;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(
        strokeWidth: 3.0,
        backgroundColor: Colors.blue,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}