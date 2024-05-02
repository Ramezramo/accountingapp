class Settings {
  int id;
  String key;
  String value;

  Settings({required this.id, required this.key, required this.value});

  // Convert a Settings object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'value': value,
    };
  }

  // Convert a Map object into a Settings
  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      id: map['id'],
      key: map['key'],
      value: map['value'],
    );
  }

  @override
  String toString() {
    return 'Settings{id: $id, key: $key, value: $value}';
  }
}
