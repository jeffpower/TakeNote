import 'package:flutter/material.dart';

class SingleItem extends StatelessWidget {
  SingleItem({
    @required this.title,
    @required this.date,
    // this.isLastItem
  });

  final String title;
  final String date;
  // bool isLastItem = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(5),
          leading: Icon(
            Icons.text_fields, size: 50.0
          ),
          title: Text(
            '$title', style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500
            ),
          ),

          subtitle: Text(
            '$date',
            maxLines: 2,
          ),
      ),
      
      // !isLastItem ? new Divider() : new SizedBox(height: 0.0,)
      ],
    );
  }
}