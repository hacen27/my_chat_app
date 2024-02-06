import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/chat_page.dart';
import 'package:my_chat_app/pages/screenprofiles.dart';
import 'package:my_chat_app/pages/widgets/profile_item.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';
import '../providers/coversationprovider.dart';

class ConversationsPage extends StatelessWidget {
  static const path = "/conversation";

  const ConversationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CoversationProvider(),
        child: _ConversationsPage());
  }
}

class _ConversationsPage extends StatelessWidget {
  const _ConversationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoversationProvider>();
    return Scaffold(
        appBar: AppBar(
          title: Text(LocalizationsHelper.msgs(context).conversationLabel),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              tooltip:
                  LocalizationsHelper.msgs(context).createNewConversationButton,
              onPressed: () {
                Navigator.pushNamed(context, ProfilesScreen.path);
              },
            ),
          ],
        ),
        body: provider.loading
            ? ListView.builder(
                itemCount: provider.conversationsParticipant.length,
                itemBuilder: (context, index) {
                  final conversation = provider.conversationsParticipant[index];
                  return ListTile(
                    onTap: () => {
                      Navigator.pushNamed(context, ChatPage.path,
                          arguments: Arguments(
                              Id: conversation.conversationId,
                              title: conversation.conversation.title)),
                    },
                    title: ProfileItem(
                      title: conversation.conversation.title,
                    ),
                    subtitle: Text('  ' +
                        '${format(conversation.createdAt, locale: 'en_short')}'),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}