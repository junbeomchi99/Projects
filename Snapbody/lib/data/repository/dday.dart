
import 'package:snapbody/data/model/dday.dart';
import 'package:sqflite/sqflite.dart';

import '../datasource/sqflite/data_source.dart';

class DdayRepository {

  Future<void> create(Dday dday) async {
    var db = await DataSource.instance.db;

    await db.insert("dday", dday.toMap());
  }

  Future<void> update(Dday dday) async {
    var db = await DataSource.instance.db;

    await db.update("dday", dday.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Dday?> get(int id) async {
    var db = await DataSource.instance.db;

    List<Map<String, dynamic>> maps = await db.query("dday",
        columns: ["id", "weightTo", "weightFrom", "comment", "createDate",  "modifyDate", "endDate"],
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Dday.fromMap(maps.first);
    }
    return null;
  }

  Future<void> delete(int id) async {
    var db = await DataSource.instance.db;
    await db.delete("dday", where: 'id = ?', whereArgs: [id]);
  }

}