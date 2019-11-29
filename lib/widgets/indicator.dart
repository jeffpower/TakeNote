import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  Indicator({
    @required this.width
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.0,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.purple
      ),
    );
  }
}