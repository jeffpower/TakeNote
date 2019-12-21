import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/core/models/note.dart';
import 'package:take_note/core/viewmodels/cloud_model.dart';
import 'package:take_note/core/viewmodels/documents_model.dart';
import 'package:take_note/locator.dart';
import 'package:take_note/ui/widgets/item.dart';

class CloudView extends StatefulWidget {
  @override
  _CloudViewState createState() => _CloudViewState();
}

class _CloudViewState extends State<CloudView> {
  List<Note> notesList;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CloudModel>(context);
    Size size = MediaQuery.of(context).size;
    double deviceHeight = size.height;
    double deviceWidth = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('C l o u d'),
        elevation: 1.0,
      ),
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        child: StreamBuilder(
          stream: model.getDocuments(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              notesList = snapshot.data.documents
                  .map((doc) => Note.fromMap(doc.data, doc.documentID))
                  .toList();

              return notesList.length != 0
                  ? ListView.builder(
                      itemCount: notesList.length,
                      itemBuilder: (context, position) => GestureDetector(
                            onLongPress: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return BottomSheet(
                                      onClosing: () {},
                                      builder: (context) {
                                        return Container(
                                          height: 200.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text('Options',
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                ListTile(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    model.removeDocument(
                                                        notesList[position]
                                                            .stringId);
                                                  },
                                                  leading: Icon(Icons.delete),
                                                  title: Text(
                                                      'Delete from cloud',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),

                                                 ListTile(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                   
                                                  },
                                                  leading: Icon(Icons.save_alt),
                                                  title: Text(
                                                      'Save locally',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  });
                            },
                            child: SingleItem(
                              title: notesList[position].title,
                              date: notesList[position].date,
                            ),
                          ))
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.cloud_off,
                            size: 130,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'No synced files',
                            style: TextStyle(fontSize: 20.0),
                          )
                        ],
                      ),
                    );
            } else {
              return Text('Fetching');
            }
          },
        ),
      ),
    );
  }
}
