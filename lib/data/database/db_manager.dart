import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  DatabaseManager._();
  static DatabaseManager db = DatabaseManager._();

  Database? _database;

  Future<Database> get database async =>
      _database == null ? await _initDB() : _database!;

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "notes.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute(
          '''
        CREATE TABLE Notes (
          id INTEGER PRIMARY KEY,
          title TEXT,
          content TEXT,
          createAt TEXT
        )''',
        );
      },
    );
  }

  Future closeDB() async => db._database!.close();
}
