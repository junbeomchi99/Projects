import 'dart:typed_data';

class UserInfo {
  final int? id;
  final String name;
  final Uint8List profileImage;
  final String pushYn;
  final String healthAppYn;
  final String profile;
  final int createDate;
  final int modifyDate;

  const UserInfo({
    this.id,
    required this.name,
    required this.profileImage,
    required this.pushYn,
    required this.healthAppYn,
    required this.profile,
    required this.createDate,
    required this.modifyDate,
  });


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map["id"] = id;
    }
    map["name"] = name;
    map["profile_image"] = profileImage;
    map["push_yn"] = pushYn;
    map["health_app_yn"] = healthAppYn;
    map["profile"] = profile;
    map["create_date"] = createDate;
    map["modify_date"] = modifyDate;

    return map;
  }

}