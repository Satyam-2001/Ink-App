import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class InitDatabase {
  Database? db;
  final String databaseName;

  InitDatabase(this.databaseName);

  Future<Database> getDtabase() async {
    if (db == null) {
      return db!;
    }
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final dbPath = join(appDir.path, databaseName);
    db = await databaseFactoryIo.openDatabase(dbPath);
    return db!;
  }
}

final settingsDatabase = InitDatabase("settings.db");
final toolsDatabase = InitDatabase("tools.db");
