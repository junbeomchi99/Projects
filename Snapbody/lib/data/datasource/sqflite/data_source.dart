import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DataSource {
  static final DataSource instance = DataSource._internal();

  factory DataSource() {
    return instance;
  }

  DataSource._internal();

  static Database? _db;
  Future<Database> get db async => _db ??= await initDB();

  initDB() async {
    String path = join(await getDatabasesPath(), 'database.db');

    var theDb = await openDatabase(path, version: 1, onCreate: createDB);
    return theDb;
  }

  createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE user_info(id INTEGER PRIMARY KEY, name TEXT, profile_image BLOB, "
        "push_yn TEXT, health_app_yn TEXT, profile TEXT, create_date INTEGER, modify_date INTEGER )");
    await db.execute(
        "CREATE TABLE album(id INTEGER PRIMARY KEY, album_type TEXT, file_path TEXT, "
        "comment TEXT, detail TEXT, create_date INTEGER, modify_date INTEGER )");
    await db.execute(
        "CREATE TABLE video(id INTEGER PRIMARY KEY, name TEXT, file_path TEXT, "
        "comment TEXT, type TEXT, create_date INTEGER, modify_date INTEGER )");
    await db.execute(
        "CREATE TABLE dday (id INTEGER PRIMARY KEY, weight_to INTEGER, weight_from INTEGER, "
        "comment TEXT, create_date INTEGER, modify_date INTEGER, end_date INTEGER )");
    await db
        .execute("CREATE TABLE weight (id INTEGER PRIMARY KEY, weight INTEGER, "
            " create_date INTEGER )");
  }

  Future close() async {
    var dbClient = _db;
    return dbClient?.close();
  }
}
