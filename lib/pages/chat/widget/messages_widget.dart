import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/chat/widget/message_widget.dart';

import 'package:swipe_to/swipe_to.dart';

import '../../../models/message.dart';

class MessagesWidget extends StatelessWidget {
  final Message message;
  final ValueChanged<Message> onSwipedMessage;

  const MessagesWidget({
    required this.onSwipedMessage,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onRightSwipe: (details) {
        onSwipedMessage(message);
      },
      child: MessageWidget(
        message: message,
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      );
}
