class Dday {
  late int _id;
  late int _weightTo;
  late int _weightFrom;
  late String _comment;
  late int _createDate;
  late int _modifyDate;
  late int _endDate;

  int get id => _id;
  int get weightTo => _weightTo;
  int get weightFrom => _weightFrom;
  String get comment => _comment;
  int get createDate => _createDate;
  int get modifyDate => _modifyDate;
  int get endDate => _endDate;

  Dday(this._id, this._weightTo, this._weightFrom, this._comment, this._endDate,
      this._createDate, this._modifyDate);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["weightTo"] = _weightTo;
    map["weightFrom"] = _weightFrom;
    map["comment"] = _comment;
    map["endDate"] = _endDate;
    map["createDate"] = _createDate;
    map["modifyDate"] = _modifyDate;

    return map;
  }

  Dday.fromMap(Map<String, dynamic> map) {
    _weightTo = map["weightTo"];
    _weightFrom = map["weightFrom"];
    _comment = map["comment"];
    _endDate = map["endDate"];
    _createDate = map["createDate"];
    _modifyDate = map["modifyDate"];
  }
}
