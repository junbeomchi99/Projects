class Weight {
  late int _id;
  late int _weight;
  late int _createDate;

  int get id => _id;
  int get weight => _weight;
  int get createDate => _createDate;

  Weight(this._id, this._weight, this._createDate);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["weight"] = _weight;
    map["createDate"] = _createDate;

    return map;
  }

  Weight.fromMap(Map<String, dynamic> map) {
    _weight = map["weight"];
    _createDate = map["createDate"];
  }
}
