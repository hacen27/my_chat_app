import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/conversation/conversations_page.dart';
import 'package:my_chat_app/pages/home/home_page.dart';
import 'package:my_chat_app/pages/profile/widgets/profile_item_add_to_conversation.dart';
import 'package:my_chat_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/localizations_helper.dart';

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({Key? key}) : super(key: key);
  static const path = '/profiles';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ProfileProvider(), child: _ProfilesScreen());
  }
}

class _ProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.amber,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: prov.isSearching
            ? TextField(
                controller: prov.searchTextController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Find  a Profile...',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 18),
                onChanged: (searchProfile) {
                  prov.addSearChedForItemsToSearchedList(searchProfile);
                },
              )
            : const Text(
                'Profiles',
              ),
        actions: [
          if (prov.isSearching)
            IconButton(
              onPressed: () {
                prov.stopSearching();
              },
              icon: const Icon(
                Icons.clear,
              ),
            )
          else
            IconButton(
              onPressed: () => prov.starSearch(),
              icon: const Icon(
                Icons.search,
              ),
            ),
        ],
      ),
      body: !prov.isComplete
          ? SingleChildScrollView(
              child: Column(
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
                            backgroundColor:
                                const Color.fromARGB(255, 216, 141, 27),
                          ),
                          child: Text(
                              LocalizationsHelper.msgs(context).leaveButton),
                        ),
                        const SizedBox(width: 150),
                        ElevatedButton(
                          onPressed: () {
                            prov.setComplete();
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
                        itemCount: prov.searchTextController.text.isEmpty
                            ? prov.allProfiles.length
                            : prov.searchFonProfiles.length,
                        itemBuilder: (ctx, index) {
                          bool? isSelected = prov.isProfileSelected(
                              prov.searchTextController.text.isEmpty
                                  ? prov.allProfiles[index].id
                                  : prov.searchFonProfiles[index].id);
                          return InkWell(
                            onTap: () {
                              prov.toggleProfileSelection(
                                prov.searchTextController.text.isEmpty
                                    ? prov.allProfiles[index].id
                                    : prov.searchFonProfiles[index].id,
                              );
                            },
                            child: ProfileItemAddToConversation(
                              profile: prov.searchTextController.text.isEmpty
                                  ? prov.allProfiles[index]
                                  : prov.searchFonProfiles[index],
                              isSelected: isSelected,
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
                        bool success = await prov.addToConversation();

                        if (success && context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomePage.path,
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
