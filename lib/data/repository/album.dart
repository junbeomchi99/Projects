import 'package:snapbody/data/datasource/sqflite/data_source.dart';
import 'package:snapbody/data/model/album.dart';
import 'package:sqflite/sqflite.dart';

class AlbumRepository {

  Future<void> create(Album album) async {
    var db = await DataSource.instance.db;
    await db.insert("album", album.toMap());
  }

  Future<void> update(Album album) async {
    var db = await DataSource.instance.db;
    await db.update("album", album.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Album?> get(int id) async {
    var db = await DataSource.instance.db;

    List<Map<String, dynamic>> maps = await db.query("album",
        columns: ["id", "albumType", "filePath", "comment", "detail", "createDate", "modifyDate"],
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Album.fromMap(maps.first);
    }
    return null;
  }

  Future<void> delete(int id) async {
    var db = await DataSource.instance.db;
    await db.delete("album", where: 'id = ?', whereArgs: [id]);
  }

}