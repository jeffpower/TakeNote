import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:take_note/core/models/note.dart';
import 'package:take_note/core/models/status.dart';
import 'package:take_note/core/services/auth_utils.dart';
import 'package:take_note/core/viewmodels/documents_model.dart';
import 'package:take_note/screens/cloud_view.dart';
import 'package:take_note/screens/editor.dart';
import 'package:take_note/widgets/item.dart';
import 'package:take_note/database/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:take_note/locator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> notesList;
  int count = 0;

  @override
  void initState() {
    if (notesList == null) {
      notesList = List<Note>();
      updateListView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DocumentModel>(context);
    Size size = MediaQuery.of(context).size;
    double deviceHeight = size.height;
    double deviceWidth = size.width;

    return 
    // ChangeNotifierProvider<DocumentModel>(
    //   builder: (context) => locator<DocumentModel>(),
    //   child: Consumer<DocumentModel>(
    //     builder: (context, model, child) => 
        Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            title: Text('T a k e N o t e'),
            leading: IconButton(
              icon: Icon(
                Icons.menu,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                        onClosing: () {},
                        builder: (context) {
                          return Container(
                            height: 250.0,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Menu',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      showChooser();
                                      // changeBrightness();
                                    },
                                    leading: Icon(Icons.wb_sunny),
                                    title: Text('Brightness',
                                        style: TextStyle(fontSize: 20.0)),
                                  ),

                                   ListTile(
                                     onTap: () {
                                       Navigator.pop(context);
                                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                                         return CloudView();
                                       }));
                                     },
                                    leading: Icon(Icons.cloud),
                                    title: Text('Synced files',
                                        style: TextStyle(fontSize: 20.0)),
                                  ),

                                  ListTile(
                                    leading: Icon(Icons.settings),
                                    title: Text('Settings',
                                        style: TextStyle(fontSize: 20.0)),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    });
              },
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Icon(
                      Icons.sort,
                    ),
                  ],
                ),
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                height: deviceHeight,
                width: deviceWidth,
              ),
              Container(
                height: deviceHeight,
                width: deviceWidth,
                child: Center(
                  child: count == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.not_interested,
                              size: 100.0,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Add a new note',
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListView.builder(
                            itemCount: count,
                            itemBuilder: (BuildContext context, int position) {
                              return GestureDetector(
                                onTap: () {
                                  navigateToEditor(
                                      this.notesList[position], 'Edit note');
                                },
                                onLongPress: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return BottomSheet(
                                          onClosing: () {},
                                          builder: (context) {
                                            return Container(
                                              height: 200,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text('Options',
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    ListTile(
                                                      onTap: () async{
                                                        var success = await model.addDocument(this.notesList[position].toMap());
                                                        if(success.documentID != null) {
                                                          Navigator.pop(context);
                                                          // _showSnackbar(context, 'Note saved to cloud successfully');
                                                        } else {
                                                          // _showSnackbar(context, 'Error occured while adding to cloud');
                                                        }
                                                      },
                                                      leading:
                                                          Icon(Icons.cloud),
                                                      title: Text(
                                                          'Sync to cloud',
                                                          style: TextStyle(
                                                              fontSize: 20.0)),
                                                  
                                                    ),
                                                    ListTile(
                                                      onTap: () {
                                                        setState(() {
                                                          _delete(
                                                              context,
                                                              notesList[
                                                                  position]);
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      leading:
                                                          Icon(Icons.delete),
                                                      title: Text('Delete',
                                                          style: TextStyle(
                                                              fontSize: 20.0)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      });
                                },
                                child: SingleItem(
                                  title: this.notesList[position].title,
                                  date: this.notesList[position].date,
                                ),
                              );
                            },
                          )),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateToEditor(
                  Note(
                    '',
                    '',
                    2,
                  ),
                  'Add note');
            },
            // backgroundColor: Color(0xff001a38),
            child: Center(
              child: Icon(
                Icons.add,
              ),
            ),
          ),
      //   ),
      // ),
    );
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      // _showSnackbar(context, 'Note deleted');
      updateListView();
    }
  }

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void changeColor() {
    DynamicTheme.of(context).setThemeData(ThemeData(
        brightness: Brightness.dark,
        primaryColor: Theme.of(context).primaryColor == Colors.blue
            ? Colors.black26
            : Colors.blue));
  }

  void showChooser() {
    showDialog<void>(
        context: context,
        builder: (context) {
          return BrightnessSwitcherDialog(
            onSelectedTheme: (brightness) {
              DynamicTheme.of(context).setBrightness(brightness);
              Navigator.pop(context);
            },
          );
        });
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNotesList();
      noteListFuture.then((noteList) {
        setState(() {
          this.notesList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void navigateToEditor(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Editor(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }
}
