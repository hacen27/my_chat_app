class Message {
  Message({
    required this.id,
    required this.conversationId,
    required this.profileId,
    required this.content,
    this.sendName,
    required this.createdAt,
    required this.isMine,
    required this.replyMessage,
  });

  final String id;

  final String conversationId;

  final String profileId;

  final String content;
  final String? sendName;

  final DateTime createdAt;

  final bool isMine;
  final Message? replyMessage;

  factory Message.fromJson(
      Map<String, dynamic> json, String? conversationId, String profileId) {
    return Message(
      id: json['id'],
      conversationId: json['conversation_id'],
      profileId: json['send_id'],
      content: json['content'],
      sendName: json['send_name'],
      createdAt: DateTime.parse(json['created_at']),
      isMine: conversationId == json['send_id'],
      replyMessage: json['replyMessage'] != null
          ? Message.fromJson(json['replyMessage'], conversationId,
              profileId) // Correctly pass parameters
          : null,
    );
  }

  Message.fromMap({
    required Map<String, dynamic> map,
    required String myUserId,
  })  : id = map['id'],
        conversationId = map['conversation_id'],
        profileId = map['send_id'],
        content = map['content'],
        createdAt = DateTime.parse(map['created_at']),
        sendName = map['send_name'],
        isMine = myUserId == map['send_id'],
        replyMessage = null;
}
