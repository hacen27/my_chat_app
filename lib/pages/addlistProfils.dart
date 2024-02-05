import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/chat_page.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:my_chat_app/pages/widgets/profileItemAddToConversation.dart';
import 'package:my_chat_app/providers/addOtherProfileProvider.dart';
import 'package:provider/provider.dart';

class Addprofiles extends StatelessWidget {
  const Addprofiles({Key? key}) : super(key: key);
  static const path = "/addprofils";

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Arguments;

    return ChangeNotifierProvider(
      create: (_) => AddlistprofilesProvider(conversationId: arguments.Id),
      child: _Addprofiles(),
    );
  }
}

class _Addprofiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.watch<AddlistprofilesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter des profils"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          if (prov.profilIds.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    prov.resetSelection();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 216, 141, 27),
                  ),
                  child: const Text('Annuler'),
                ),
                const SizedBox(width: 150),
                ElevatedButton(
                  onPressed: () {
                    prov.addProfile(prov.profilIds, prov.conversationId);
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, ConversationsPage.path, (route) => false);
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
