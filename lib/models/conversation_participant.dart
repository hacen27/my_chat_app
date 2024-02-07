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
