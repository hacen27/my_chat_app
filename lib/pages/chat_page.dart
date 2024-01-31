import 'package:flutter/material.dart';

import 'package:my_chat_app/models/message.dart';
import 'package:my_chat_app/pages/register_page.dart';
import 'package:my_chat_app/pages/widgets/chatBubble.dart';
import 'package:my_chat_app/pages/widgets/messageBar.dart';
import 'package:my_chat_app/providers/chatProvider.dart';
import 'package:my_chat_app/utils/constants.dart';
import 'package:provider/provider.dart';

import '../utils/localizations_helper.dart';

class ChatPage extends StatefulWidget {
  static const path = "/chat";

  ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final conversationId = ModalRoute.of(context)!.settings.arguments;
    return ChangeNotifierProvider(
      create: (context) => ChatProvider.initialize(conversationId as String),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocalizationsHelper.msgs(context).chatApp),
          actions: [
            TextButton(
              onPressed: () async {
                await supabase.auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, RegisterPage.path, (route) => false);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
        body: Consumer<ChatProvider?>(builder: (context, chtPro, child) {
          if (chtPro == null) {
            return const Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 20, 65, 190)));
          }
          // chtPro.loadProfileCache;
          return StreamBuilder<List<Message>>(
            stream: chtPro.messagesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final messages = snapshot.data!;
                return Column(
                  children: [
                    Expanded(
                      child: messages.isEmpty
                          ? Center(
                              child: Text(LocalizationsHelper.msgs(context)
                                  .startConversation),
                            )
                          : ListView.builder(
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                // chtPro.loadProfileCache(message.profileId);
                                return ChatBubble(
                                  message: message,
                                );
                              },
                            ),
                    ),
                    MessageBar(conversationId: conversationId as String),
                  ],
                );
              } else {
                return preloader;
              }
            },
          );
        }),
      ),
    );
  }
}
