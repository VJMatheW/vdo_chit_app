import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../enums_and_variables/sql.dart';

abstract class DBServiceInterface {
  dbExists();
  openDB();
  deleteDB();
  create(String sql, List<dynamic> args);
  read(String sql, List<dynamic> args);
  update();
  delete();
}

class DBService implements DBServiceInterface {
  final DB_NAME = "chit.db";
  Database db;

  DBService() {
    openDatabase(DB_NAME,
            version: 1, onConfigure: _onConfigure, onCreate: _onCreate)
        .then((database) {
      this.db = database;
    });
  }

  @override
  Future<bool> dbExists() async {
    String databasesPath = await getDatabasesPath();
    // print("Database Path : $databasesPath");
    String path = join(databasesPath, DB_NAME);
    // print("Path : $path");
    bool status = await databaseExists(path);
    print("DB exists : $status");
    return status;
  }

  // configure DB when opening
  _onConfigure(Database db) async {
    print("Executing configure db");
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  // executes when creating for the first time
  _onCreate(Database db, int version) async {
    print("Executing onCreate in db");
    // await db.execute("CREATE TABLE Test (id INTEGER PRIMARY KEY, value TEXT)");
    await db.execute(Sql.CHIT_CONFIG);
    await db.execute(Sql.MEMBER_CONFIG);
    await db.execute(Sql.CHIT);
    await db.execute(Sql.CHIT_MEMBER);
    await db.execute(Sql.CHIT_MONTH);
    await db.execute(Sql.CHIT_MONTHLY_MEMBER_TR);
    await db.execute(Sql.PAYMENT_MODE);
    await db.execute(Sql.TRANSACTIONS);
    // populate data
    // await db.insert(...);
  }

  @override
  Future<void> openDB() async {
    if (db != null) {
      print("Opening DB");
      db = await openDatabase(DB_NAME,
          version: 1, onConfigure: _onConfigure, onCreate: _onCreate);
    } else {
      print("db is null");
    }
  }

  @override
  Future<void> deleteDB() async {
    await deleteDatabase(DB_NAME);
  }

  @override
  Future<int> create(String sql, List<dynamic> args) async {
    int id = await db.rawInsert(sql, args);
    print('inserted ID: $id');
    return id;
  }

  @override
  delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Map>> read(String sql, List<dynamic> args) async {
    List<Map> result = await db.rawQuery(sql, args);
    return result;
  }

  @override
  update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
