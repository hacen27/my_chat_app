import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/add_profils.dart';
import 'package:my_chat_app/pages/chat_page.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';
import 'package:provider/provider.dart';

import '../providers/coversation_details_provider.dart';

class ConversationDetails extends StatelessWidget {
  static const path = "/ProfilConversation";

  const ConversationDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ArgumentsChat;
    return ChangeNotifierProvider(
        create: (_) => CoversationDetailsProvider(
            conversationId: arguments.id, context: context),
        child: _ConversationDetails());
  }
}

class _ConversationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ArgumentsChat;
    final provideControleur = context.watch<CoversationDetailsProvider>();

    return Scaffold(
      appBar: AppBar(
          title: Text(LocalizationsHelper.msgs(context).infoLabel),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          CircleAvatar(
            radius: 60,
            child: Text(arguments.title, style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddProfiles.path,
                      arguments: ArgumentsChat(
                          id: arguments.id, title: arguments.title));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text(LocalizationsHelper.msgs(context).addButton),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(LocalizationsHelper.msgs(context)
                            .confirmationLabel),
                        content: Text(LocalizationsHelper.msgs(context)
                            .leaveConversationConfirmation),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                                LocalizationsHelper.msgs(context).cancelButton),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                                LocalizationsHelper.msgs(context).leaveButton),
                            onPressed: () {
                              provideControleur.deletProfile();
                              if (context.mounted) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    ConversationsPage.path, (route) => false);
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(LocalizationsHelper.msgs(context).leaveButton),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(LocalizationsHelper.msgs(context).membersLabel),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: provideControleur.profileParticipant.length,
              itemBuilder: (context, index) {
                final pp = provideControleur.profileParticipant[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60, top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        child: Text(
                            pp.profile.username.toUpperCase().substring(0, 1),
                            style: const TextStyle(fontSize: 12)),
                      ),
                      Text(pp.profile.username,
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
