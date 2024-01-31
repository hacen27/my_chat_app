import 'package:my_chat_app/models/profile.dart';

class ConversationParticpant {
  int id;
  DateTime createdAt;
  String conversationId;
  Conversation conversation;

  ConversationParticpant({
    required this.id,
    required this.createdAt,
    required this.conversationId,
    required this.conversation,
  });

  factory ConversationParticpant.fromJson(Map<String, dynamic> json) {
    return ConversationParticpant(
        id: json['id'],
        conversationId: json['conversation_id'],
        createdAt: DateTime.parse(json['created_at']),
        conversation: Conversation.fromJson(json['conversation']));
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

class Conversation {
  String title;

  Conversation({
    required this.title,
  });
  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(title: json['title']);
  }
}
