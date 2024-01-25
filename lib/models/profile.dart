class Profile {
  Profile({
    required this.id,
    required this.username,
    this.createdAt,
  });

  late String id;

  late String username;

  late DateTime? createdAt;

  Profile.toMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        createdAt = DateTime.parse(map['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  Profile.fromJson(Map<String, dynamic>? json) {
    id = json!["id"];
    username = json["username"];
    createdAt = DateTime.parse(json["created_at"]);
  }

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        createdAt = DateTime.parse(map['created_at']);
}

final Map<String, Profile> _profileCache = {};
