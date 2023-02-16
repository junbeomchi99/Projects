class Album {
  late int _id;
  late String _albumType;
  late String _filePath;
  late String _comment;
  late String _detail;
  late int _createDate;
  late int _modifyDate;

  int get id => _id;
  String get albumType => _albumType;
  String get filePath => _filePath;
  String get comment => _comment;
  String get detail => _detail;
  int get createDate => _createDate;
  int get modifyDate => _modifyDate;

  Album(this._id, this._albumType, this._filePath, this._comment, this._detail,
      this._createDate, this._modifyDate);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["albumType"] = _albumType;
    map["filePath"] = _filePath;
    map["comment"] = _comment;
    map["detail"] = _detail;
    map["createDate"] = _createDate;
    map["modifyDate"] = _modifyDate;

    return map;
  }

  Album.fromMap(Map<String, dynamic> map) {
    _albumType = map["albumType"];
    _filePath = map["filePath"];
    _comment = map["comment"];
    _detail = map["detail"];
    _createDate = map["createDate"];
    _modifyDate = map["modifyDate"];
  }
}
