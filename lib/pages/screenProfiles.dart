import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/widgets/profilItem.dart';
import 'package:my_chat_app/pages/widgets/profileItemAddToConversation.dart';
import 'package:provider/provider.dart';
import '../providers/profileProvider.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({Key? key}) : super(key: key);
  static const path = "/profiles";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProfileProvider(), child: _ProfilesScreen());
  }
}

class _ProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provideControleur = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: provideControleur.isSearching
            ? const BackButton(color: Colors.black)
            : Container(),
        title: provideControleur.isSearching
            ? TextField(
                controller: provideControleur.searchTextCotrollor,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'find  a Profile...',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 18),
                onChanged: (searchProfile) {
                  provideControleur
                      .addSearChedForitemsToserchedList(searchProfile);
                },
              )
            : const Text(
                'Profiles',
                style: TextStyle(color: Colors.black),
              ),
        actions: [
          if (provideControleur.isSearching)
            IconButton(
              onPressed: () {
                provideControleur.clearSearch();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.black12,
              ),
            )
          else
            IconButton(
              onPressed: () => provideControleur.starSearch(context),
              icon: const Icon(
                Icons.search,
                color: Colors.black12,
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: provideControleur.searchTextCotrollor.text.isEmpty
                  ? provideControleur.allProfiles!.length
                  : provideControleur.searchFonProfiles!.length,
              itemBuilder: (ctx, index) {
                return ProfileItemAddToConversation(
                  newConversation: () => provideControleur.addtoConversation(
                      provideControleur.isSearching
                          ? provideControleur.searchFonProfiles![index].id
                          : provideControleur.allProfiles![index].id),
                  // conversationId: provideControleur.conversationId,
                  profile: provideControleur.searchTextCotrollor.text.isEmpty
                      ? provideControleur.allProfiles![index]
                      : provideControleur.searchFonProfiles![index],
                );
              }),
        ),
      ),
    );
  }
}
