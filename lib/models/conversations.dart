import 'package:my_chat_app/models/profile.dart';

class Conversation {
  String id;
  DateTime createdAt;
  List<Messages> messages;
  List<Profile> profiles;

  Conversation({
    required this.id,
    required this.createdAt,
    required this.messages,
    required this.profiles,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      messages: (json['message'] as List<dynamic>)
          .map((message) => Messages.fromJson(message))
          .toList(),
      profiles: (json['profile'] as List<dynamic>)
          .map((profile) => Profile.fromJson(profile))
          .toList(),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'created_at': createdAt.toIso8601String(),
  //     'messages': messages.map((message) => message.toJson()).toList(),
  //     'profiles': profiles.toJson(),
  //   };
  // }
}

class Messages {
  String id;
  String content;
  DateTime createdAt;

  Messages({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class Newconversation {
  String id;
  DateTime createdAt;

  Newconversation({
    required this.id,
    required this.createdAt,
  });

  factory Newconversation.fromJson(Map<String, dynamic> json) {
    return Newconversation(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
