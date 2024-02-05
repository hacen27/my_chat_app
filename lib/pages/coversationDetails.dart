import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/addlistProfils.dart';
import 'package:my_chat_app/pages/chat_page.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:provider/provider.dart';

import '../providers/coversationDetailsProvider.dart';

class ConversationDetails extends StatelessWidget {
  static const path = "/ProfilConversation";

  const ConversationDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Arguments;
    return ChangeNotifierProvider(
        create: (context) =>
            CoversationDetailsProvider(conversationId: arguments.Id),
        child: _ConversationDetails());
  }
}

class _ConversationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Arguments;
    final provideControleur = context.watch<CoversationDetailsProvider>();

    return Scaffold(
      appBar: AppBar(
          title: const Text("Info"),
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
                  Navigator.pushNamed(context, Addprofiles.path,
                      arguments:
                          Arguments(Id: arguments.Id, title: arguments.title));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Ajouter'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text(
                            'Voulez-vous vraiment quitter la discussion ?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Annuler'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Quitter'),
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
                child: const Text('Quitter'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Les Membres"),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: provideControleur.profileParticipant.length,
              itemBuilder: (context, index) {
                final pp = provideControleur.profileParticipant[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60, top: 6),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
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
