
import 'package:snapbody/data/model/video.dart';
import 'package:sqflite/sqflite.dart';

import '../datasource/sqflite/data_source.dart';

class VideoRepository {

  Future<void> create(Video video) async {
    var db = await DataSource.instance.db;

    await db.insert("video", video.toMap());
  }

  Future<void> update(Video video) async {
    var db = await DataSource.instance.db;

    await db.update("video", video.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Video?> get(int id) async {
    var db = await DataSource.instance.db;
    List<Map<String, dynamic>> maps = await db.query("video",
        columns: ["id", "name", "filePath", "comment", "type", "createDate", "modifyDate"],
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Video.fromMap(maps.first);
    }
    return null;
  }

  Future<void> delete(int id) async {
    var db = await DataSource.instance.db;
    await db.delete("video", where: 'id = ?', whereArgs: [id]);
  }

}