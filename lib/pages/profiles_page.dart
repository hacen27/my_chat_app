import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:my_chat_app/pages/widgets/profile_item_add_to_conversation.dart';
import 'package:my_chat_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import '../utils/localizations_helper.dart';

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({Key? key}) : super(key: key);
  static const path = "/profiles";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ProfileProvider(context: context),
        child: _ProfilesScreen());
  }
}

class _ProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: prov.isSearching
            ? TextField(
                controller: prov.searchTextCotrollor,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Find  a Profile...',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 18),
                onChanged: (searchProfile) {
                  prov.addSearChedForitemsToserchedList(searchProfile);
                },
              )
            : const Text(
                'Profiles',
                style: TextStyle(color: Colors.black),
              ),
        actions: [
          if (prov.isSearching)
            IconButton(
              onPressed: () {
                prov.clearSearch();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
            )
          else
            IconButton(
              onPressed: () => prov.starSearch(context),
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
        ],
      ),
      body: !prov.isComplet
          ? SingleChildScrollView(
              child: Column(
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
                            backgroundColor:
                                const Color.fromARGB(255, 216, 141, 27),
                          ),
                          child: Text(
                              LocalizationsHelper.msgs(context).leaveButton),
                        ),
                        const SizedBox(width: 150),
                        ElevatedButton(
                          onPressed: () {
                            prov.setComplet();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                          child:
                              Text(LocalizationsHelper.msgs(context).addButton),
                        ),
                      ],
                    ),
                  const SizedBox(height: 30),
                  SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: prov.searchTextCotrollor.text.isEmpty
                            ? prov.allProfiles.length
                            : prov.searchFonProfiles.length,
                        itemBuilder: (ctx, index) {
                          bool? isSeleted = prov.isProfileSelected(
                              prov.searchTextCotrollor.text.isEmpty
                                  ? prov.allProfiles[index].id
                                  : prov.searchFonProfiles[index].id);
                          return InkWell(
                            onTap: () {
                              prov.toggleProfileSelection(
                                prov.searchTextCotrollor.text.isEmpty
                                    ? prov.allProfiles[index].id
                                    : prov.searchFonProfiles[index].id,
                              );
                            },
                            child: ProfileItemAddToConversation(
                              profile: prov.searchTextCotrollor.text.isEmpty
                                  ? prov.allProfiles[index]
                                  : prov.searchFonProfiles[index],
                              isSelected: isSeleted,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    controller: prov.textTitleController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      fillColor: Colors.blue,
                      hintText: LocalizationsHelper.msgs(context)
                          .conversationTitlePlaceholder,
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          elevation: 2,
                          backgroundColor: Colors.amber),
                      onPressed: () async {
                        bool succes = await prov.addtoConversation();
                        if (succes) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            ConversationsPage.path,
                            (route) => false,
                          );
                        }
                      },
                      child: Text(LocalizationsHelper.msgs(context).addButton,
                          style: const TextStyle(fontSize: 20)))
                ],
              ),
            ),
    );
  }
}
