import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

String tablePageName = 'all_pages';
String tableLetterName = 'letter_images';

String tableLetter =
    'CREATE TABLE $tableLetterName(id TEXT PRIMARY KEY, letter TEXT, file TEXT, baseline INTEGER, sizeScale REAL)';
String tablePage =
    'CREATE TABLE $tablePageName(id TEXT PRIMARY KEY, image TEXT, xpos INTEGER, ypos INTEGER, lineheight INTEGER)';

class SQLDatabase {
  Database? database;

  Future<Database> getDatabase() async {
    if (database != null) {
      return database!;
    }
    final dbPath = await sql.getDatabasesPath();
    database = await sql.openDatabase(
      path.join(dbPath, 'ink_app_2.db'),
      onCreate: (db, version) async {
        await db.execute(tableLetter);
        await db.execute(tablePage);
      },
      version: 3,
    );
    return database!;
  }
}
