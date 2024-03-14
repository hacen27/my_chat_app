import 'package:flutter/material.dart';

import 'package:my_chat_app/pages/home/home_page.dart';
import 'package:my_chat_app/pages/profile/widgets/profile_item_add_to_conversation.dart';

import 'package:my_chat_app/providers/add_other_profile_provider.dart';
import 'package:provider/provider.dart';

class AddProfiles extends StatelessWidget {
  final String conversationId;
  const AddProfiles({Key? key, required this.conversationId}) : super(key: key);
  static const path = '/addProfiles';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddListProfilesProvider(conversationId: conversationId),
      child: _AddProfiles(),
    );
  }
}

class _AddProfiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.watch<AddListProfilesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter des Profiles"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          if (prov.profileIds.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    prov.resetSelection();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 216, 141, 27),
                  ),
                  child: const Text('Annuler'),
                ),
                const SizedBox(width: 150),
                ElevatedButton(
                  onPressed: () {
                    prov.addProfile(prov.profileIds, prov.conversationId);
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomePage.path, (route) => false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text("Ajouter"),
                ),
              ],
            ),
          const SizedBox(height: 30),
          SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: prov.profiles.length,
              itemBuilder: (ctx, index) {
                bool? isSelected =
                    prov.isProfileSelected(prov.profiles[index].id);
                return InkWell(
                  onTap: () {
                    prov.toggleProfileSelection(prov.profiles[index].id);
                  },
                  child: ProfileItemAddToConversation(
                      profile: prov.profiles[index], isSelected: isSelected),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
