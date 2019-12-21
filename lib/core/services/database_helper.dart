import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:take_note/core/constants/constants.dart';
import 'package:take_note/core/models/note.dart';

class DatabaseHelper {
  
  // Singleton databaseHelper
  static DatabaseHelper _databaseHelper;
  static Database _database;
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if(_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if(_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '${Constants.DBNAME}';

    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);

    return notesDatabase;
  }


  void _createDb(Database db, int version) async {
    await db.execute('CREATE TABLE ${Constants.noteTable}(${Constants.colId} INTEGER PRIMARY KEY AUTOINCREMENT, ${Constants.colTitle} TEXT, '
    '${Constants.colDescription} TEXT, ${Constants.colPriority} INTEGER, ${Constants.colDate} TEXT)'
    );
  }


  // Fetch operation
  Future<List<Map<String, dynamic>>> getNotesMapList() async {
    var dbClient = await this.database;
    var result = await dbClient.query(Constants.noteTable, orderBy: '${Constants.colPriority} ASC');

    return result;

  }

  // Insert operation
  Future<int> insertNote(Note note) async {
    var dbClient = await this.database;
    var result = dbClient.insert(Constants.noteTable, note.toMap());

    return result;
  }

  // Updaate operation
  Future<int> updateNote(Note note) async {
    var dbClient = await this.database;
    var result = dbClient.update(Constants.noteTable, note.toMap(), where: '${Constants.colId} = ?', whereArgs: [note.id]);

    return result;

  }

  // Delete operation
  Future<int> deleteNote(int id) async {
    var dbClient = await this.database;
    var result = dbClient.rawDelete('DELETE FROM ${Constants.noteTable} WHERE ${Constants.colId} = $id');

    return result;
  }

  // Get number of note objects in the database
  Future<int> getCount() async {
    var dbClient = await this.database;
    List<Map<String, dynamic>> X = await dbClient.rawQuery('SELECT COUNT (*) from ${Constants.noteTable}');
    int result = Sqflite.firstIntValue(X);

    return result;
  }

  Future<List<Note>> getNotesList() async {
    var noteMapList = await getNotesMapList();
    int count = noteMapList.length;

    List<Note> noteList = List<Note>();

    for(int i = 0; i < count; i++) {
      noteList.add(Note.fromMap(noteMapList[i]));
    }

    return noteList;
  }


}