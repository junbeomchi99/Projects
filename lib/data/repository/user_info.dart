
import 'package:sqflite/sqflite.dart';

import '../datasource/sqflite/data_source.dart';
import '../model/user_info.dart';

class UserInfoRepository {

  Future<int> create(UserInfo userInfo) async {
    var db = await DataSource.instance.db;
    return await db.insert("user_info", userInfo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(UserInfo userInfo) async {
    var db = await DataSource.instance.db;

    await db.update("user_info", userInfo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<UserInfo?> get(int id) async {
    var db = await DataSource.instance.db;

    List<Map<String, dynamic>> maps = await db.query("user_info",
        columns: ["id", "name", "profile_image", "push_yn", "health_app_yn", "profile", "create_date", "modify_date"],
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return UserInfo(
          id: maps[0]['id'],
          name: maps[0]['name'],
          profileImage: maps[0]['profile_image'],
          pushYn: maps[0]['push_yn'],
          healthAppYn: maps[0]['health_app_yn'],
          profile: maps[0]['profile'],
          createDate: maps[0]['create_date'],
          modifyDate: maps[0]['modify_date']);
    }
    return null;
  }

  Future<void> delete(int id) async {
    var db = await DataSource.instance.db;
    await db.delete("user_info", where: 'id = ?', whereArgs: [id]);
  }

}