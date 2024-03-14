import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/chat/chat_page.dart';

import 'package:my_chat_app/pages/conversation/widgets/conversation_list.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';
import 'package:provider/provider.dart';
import '../../providers/conversations_provider.dart';

class ConversationsPage extends StatelessWidget {
  static const path = '/conversation';

  const ConversationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ConversationProvider(),
        child: const _ConversationsPage());
  }
}

class _ConversationsPage extends StatelessWidget {
  const _ConversationsPage();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ConversationProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      LocalizationsHelper.msgs(context).conversationLabel,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      tooltip: LocalizationsHelper.msgs(context)
                          .createNewConversationButton,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: provider.conversationsParticipant.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final conversation = provider.conversationsParticipant[index];
                return ConversationList(
                  onTap: () => {
                    Navigator.pushNamed(
                      context,
                      Uri(
                        path: ChatPage.path,
                        queryParameters: {
                          'id': conversation.conversationId,
                          'title': conversation.conversation.title
                        },
                      ).toString(),
                    ),
                  },
                  name: conversation.conversation.title,
                  title: conversation.conversation.title,
                  messageText: 'Bonjour',
                  time: conversation.createdAt,
                  isMessageRead: true,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
