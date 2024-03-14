import 'package:flutter/material.dart';

import 'package:my_chat_app/pages/conversation/conversation_details.dart';
import 'package:my_chat_app/pages/chat/widget/messagebar.dart';
import 'package:my_chat_app/pages/chat/widget/messages_widget.dart';
import 'package:my_chat_app/pages/chat/widget/new_message_widget.dart';
import 'package:my_chat_app/providers/chat_provider.dart';
import 'package:my_chat_app/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../utils/localizations_helper.dart';

class ChatPage extends StatelessWidget {
  static const path = '/chat';
  final String conversationId;
  final String title;
  const ChatPage({Key? key, required this.conversationId, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatProvider(
        conversationId: conversationId,
      ),
      child: _ChatPage(conversationId, title),
    );
  }
}

class _ChatPage extends StatelessWidget {
  final String conversationId;
  final String title;
  const _ChatPage(
    this.conversationId,
    this.title,
  );
  @override
  Widget build(BuildContext context) {
    final chatController = context.watch<ChatProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Uri(
                            path: ConversationDetails.path,
                            queryParameters: {
                              'id': chatController.conversationId,
                              'title': title
                            },
                          ).toString(),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(myUrlAvatar),
                      ),
                      title: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        "Online",
                      ),
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.videocam_outlined,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Icon(
                      Icons.call_outlined,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<ChatProvider?>(builder: (context, chtPro, child) {
        if (chtPro == null) {
          return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 20, 65, 190)));
        } else {
          return Column(
            children: [
              Expanded(
                child: chtPro.messages.isEmpty
                    ? Center(
                        child: Text(LocalizationsHelper.msgs(context)
                            .startConversation),
                      )
                    : ListView.builder(
                        reverse: true,
                        itemCount: chtPro.messages.length,
                        itemBuilder: (context, index) {
                          final message = chtPro.messages[index];
                          int selectedIndex = 0;
                          return Column(
                            children: [
                              MessagesWidget(
                                message: message,
                                onSwipedMessage: (message) {
                                  chtPro.replyToMessage(message);
                                  chtPro.focusNode.requestFocus();
                                },
                              ),
                              if (chtPro.replyMessage != null)
                                if (selectedIndex == index)
                                  NewMessageWidget(
                                    focusNode: chtPro.focusNode,
                                    onCancelReply: chtPro.cancelReply,
                                    replyMessage: chtPro.replyMessage,
                                    conversationId: chtPro.conversationId,
                                  )
                            ],
                          );
                        },
                      ),
              ),
              if (chtPro.replyMessage == null)
                MessageBar(
                  textController: chtPro.textController,
                  onSubmit: () {
                    chtPro.submitMessage();
                  },
                ),
            ],
          );
        }
      }),
    );
  }
}
