import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/screenProfiles.dart';
import 'package:my_chat_app/pages/widgets/profilItem.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';
import '../providers/coversationProvider.dart';

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
    final provideControleur = context.watch<CoversationProvider>();
    return Scaffold(
        appBar: AppBar(
          title: Text("Conversation"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              tooltip: "Create New Conversation",
              onPressed: () {
                Navigator.pushNamed(context, ProfilesScreen.path);
                // providerCntr.createNewConversation();
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: provideControleur.conversationsParticipant.length,
          itemBuilder: (context, index) {
            final conversation =
                provideControleur.conversationsParticipant[index];
            return ListTile(
              title: ProfileItem(
                title: conversation.conversation.title,
                conversationId: conversation.conversationId,
              ),
              subtitle: Text('      ' +
                  '${format(conversation.createdAt, locale: 'en_short')}'),
            );
          },
        ));
  }
}






// return ListTile(
//               title: ProfileItem(
//                 profile: conversation.profiles.first,
//                 conversationId: conversation.id,
//               ),
//               subtitle: conversation.messages.isNotEmpty
//                   ? Text(
//                       '${format(conversation.messages.last.createdAt, locale: 'en_short')} ${conversation.messages.last.content}',
//                     )
//                   : const Text('No messages in this conversation'),
//             );