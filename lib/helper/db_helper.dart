import 'package:employee/models/employ_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DBHelper {
  late Database _db;

  String tblEmploy = "tbl_employ";

  Future<Database> get db async {
    // if (_db == null) {
    //   return _db;
    // }
    // _db = await initDatabase();
    _db = await initDatabase();

    return _db;
  }

  initDatabase() async {
    // io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentDirectory.path, 'employ.db');
    // var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    // // return db;

    var databasesPath = await getDatabasesPath();
    String paths = p.join(databasesPath, 'db_employ.db');
    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(paths, version: 1, onCreate: _onCreate);
    return notesDatabase;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE ' +
        tblEmploy +
        ' (id INTEGER PRIMARY KEY, emp_id TEXT, name TEXT, username TEXT, email TEXT, profile_image TEXT, phone TEXT, website TEXT, address TEXT, company TEXT)');
  }

  Future<Employ> add(Employ employ) async {
    var dbClient = await db;
    employ.id = (await dbClient.insert(tblEmploy, employ.toMap()));
    return employ;
  }

  Future<List<Employ>> getEmploy() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
        await dbClient.rawQuery("SELECT * FROM $tblEmploy");
    List<Employ> emp = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        emp.add(Employ.fromMap(maps[i]));
      }
    }
    return emp;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
