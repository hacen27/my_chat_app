import 'package:flutter/material.dart';
import 'package:my_chat_app/models/message.dart';
import 'package:my_chat_app/pages/chat/widget/reply_message_widget.dart';
import 'package:my_chat_app/utils/exception_catch.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../providers/account/auth_provider.dart';
import '../../../services/chat_services.dart';

class NewMessageWidget extends StatefulWidget {
  final FocusNode focusNode;

  final Message? replyMessage;
  final VoidCallback onCancelReply;
  final String conversationId;

  const NewMessageWidget({
    required this.focusNode,
    required this.replyMessage,
    required this.onCancelReply,
    required this.conversationId,
    Key? key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  static const inputTopRadius = Radius.circular(12);
  static const inputBottomRadius = Radius.circular(24);

  User? get currentUser => AuthProvider().getUser();

  final ChatServices _chatServices = ChatServices();

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    widget.onCancelReply();

    try {
      await ExceptionCatch.catchErrors(() => _chatServices.submitMessage(
          widget.conversationId,
          currentUser!.id,
          message,
          widget.replyMessage));
    } catch (e) {}

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isReplying = widget.replyMessage != null;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                if (isReplying) buildReply(),
                TextField(
                  focusNode: widget.focusNode,
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                        topLeft: isReplying ? Radius.zero : inputBottomRadius,
                        topRight: isReplying ? Radius.zero : inputBottomRadius,
                        bottomLeft: inputBottomRadius,
                        bottomRight: inputBottomRadius,
                      ),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    message = value;
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: message.trim().isEmpty ? null : sendMessage,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReply() => Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: inputTopRadius,
          topRight: inputTopRadius,
        ),
      ),
      child: widget.replyMessage != null
          ? ReplyMessageWidget(
              message: widget.replyMessage!,
              onCancelReply: widget.onCancelReply,
            )
          : const Text(" "));
}
