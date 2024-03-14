import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/profile/add_profiles.dart';
import 'package:my_chat_app/pages/conversation/conversations_page.dart';
import 'package:my_chat_app/pages/home/home_page.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';
import 'package:provider/provider.dart';

import '../../providers/conversations_details_provider.dart';

class ConversationDetails extends StatelessWidget {
  static const path = '/profileConversation';
  final String id;
  final String title;
  const ConversationDetails({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ConversationDetailsProvider(conversationId: id),
        child: _ConversationDetails(id, title));
  }
}

class _ConversationDetails extends StatelessWidget {
  final String id;
  final String title;
  const _ConversationDetails(this.id, this.title);
  @override
  Widget build(BuildContext context) {
    final provideController = context.watch<ConversationDetailsProvider>();

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
            child: Text(title, style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Uri(path: AddProfiles.path, queryParameters: {'id': id})
                        .toString(),
                  );
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
                              provideController.deleteProfile();
                              if (context.mounted) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, HomePage.path, (route) => false);
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
              itemCount: provideController.profileParticipant.length,
              itemBuilder: (context, index) {
                final pp = provideController.profileParticipant[index];
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
