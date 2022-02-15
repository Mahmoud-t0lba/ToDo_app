class Task {
  final String name;
  bool isdone;
  Task({this.name, this.isdone});
  void toogleDone() {
    isdone = !isdone;
  }

  Task.fromMap(Map map)
      : name = map['name'],
        isdone = map['isdone'];

  Map toMap() {
    return {
      'name': name,
      'isdone': isdone,
    };
  }
}
