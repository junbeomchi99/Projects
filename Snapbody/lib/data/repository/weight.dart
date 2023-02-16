
import 'package:snapbody/data/model/weight.dart';
import 'package:sqflite/sqflite.dart';

import '../datasource/sqflite/data_source.dart';

class WeightRepository {

  Future<void> create(Weight weight) async {
    var db = await DataSource.instance.db;

    await db.insert("weight", weight.toMap());
  }

  Future<void> update(Weight weight) async {
    var db = await DataSource.instance.db;

    await db.update("weight", weight.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Weight?> get(int id) async {
    var db = await DataSource.instance.db;

    List<Map<String, dynamic>> maps = await db.query("weight",
        columns: ["id", "weight",  "createDate"],
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Weight.fromMap(maps.first);
    }
    return null;
  }

  Future<void> delete(int id) async {
    var db = await DataSource.instance.db;
    await db.delete("weight", where: 'id = ?', whereArgs: [id]);
  }

}