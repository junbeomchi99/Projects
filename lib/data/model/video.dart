class Video {
  late int _id;
  late String _name;
  late String _filePath;
  late String _comment;
  late String _type;
  late int _createDate;
  late int _modifyDate;

  int get id => _id;
  String get name => _name;
  String get filePath => _filePath;
  String get comment => _comment;
  String get type => _type;
  int get createDate => _createDate;
  int get modifyDate => _modifyDate;

  Video(this._id, this._name, this._filePath, this._comment, this._type,
      this._createDate, this._modifyDate);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["filePath"] = _filePath;
    map["comment"] = _comment;
    map["type"] = _type;
    map["createDate"] = _createDate;
    map["modifyDate"] = _modifyDate;

    return map;
  }

  Video.fromMap(Map<String, dynamic> map) {
    _name = map["name"];
    _filePath = map["filePath"];
    _comment = map["comment"];
    _type = map["type"];
    _createDate = map["createDate"];
    _modifyDate = map["modifyDate"];
  }
}
