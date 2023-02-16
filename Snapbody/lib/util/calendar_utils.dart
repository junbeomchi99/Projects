class Event {
  final String type;
  final String filePath;
  final String comment;
  final String detail;

  const Event(this.type, this.filePath, this.comment, this.detail);

  @override
  String toString() => type;
}
