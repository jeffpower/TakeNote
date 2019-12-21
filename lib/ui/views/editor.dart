import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:take_note/core/services/database_helper.dart';
import 'package:take_note/core/models/note.dart';

class Editor extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  Editor(this.note, this.appBarTitle);

  @override
  _EditorState createState() => _EditorState(this.note, this.appBarTitle);
}

class _EditorState extends State<Editor> {
  String appBarTitle;
  Note note;
  DatabaseHelper databaseHelper = DatabaseHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var priorities = ['High', 'Low'];

  _EditorState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    titleController.text = note.title;
    descriptionController.text = note.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: TextStyle(),
        ),
        elevation: 1.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _delete();
              });
            },
          )
        ],
      ),
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ListTile(
                //   leading: Text('Priority', style: TextStyle(fontSize: 18),),
                //   title: DropdownButton(
                //     items: priorities.map((String dropDownStringItem) {
                //       return DropdownMenuItem<String>(
                //           value: dropDownStringItem,
                //           child: Text(dropDownStringItem));
                //     }).toList(),
                //     value: getPriorityAsString(note.priority),
                //     onChanged: (valueSelectedByUser) {
                //       setState(() {
                //         updatePriorityAsInt(valueSelectedByUser);
                //       });
                //     },
                //   ),
                // ),
                new SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: new TextFormField(
                    controller: titleController,
                    onChanged: (value) {
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(fontSize: 17.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                new SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: new TextFormField(
                    maxLines: 4,
                    controller: descriptionController,
                    onChanged: (value) {
                      updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(fontSize: 17.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                new SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 5.0,
                      ),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: AdmobBanner(
                      adUnitId: 'ca-app-pub-7063490524190385/1261988279',
                      adSize: AdmobBannerSize.LEADERBOARD,
                      
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async {
          setState(() {
            _save();
          });
        },
      ),
    );
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = priorities[0];
        break;
      case 2:
        priority = priorities[1];
        break;
    }

    return priority;
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      await databaseHelper.updateNote(note);
    } else {
      await databaseHelper.insertNote(note);
    }

    // if (result != 0) {
    //  _showAlertDialog('Status', 'Note successfully added');

    // } else {
    //   _showAlertDialog('Status', 'Error occured while adding no');
    // }
  }

  void _delete() async {
    moveToLastScreen();
    if (note.id == null) {
      _showAlertDialog('Status', 'No note added');
      return;
    }
    await databaseHelper.deleteNote(note.id);
    // if (result != 0) {
    //   _showAlertDialog('Status', 'Note successfully deleted');
    // } else {
    //   _showAlertDialog('Status' , 'Error occured while deleting note');
    // }
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
