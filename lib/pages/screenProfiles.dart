import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
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
    final prov = context.watch<ProfileProvider>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: prov.isSearching
              ? const BackButton(color: Colors.black)
              : Container(),
          title: prov.isSearching
              ? TextField(
                  controller: prov.searchTextCotrollor,
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'find  a Profile...',
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
                  color: Colors.black12,
                ),
              )
            else
              IconButton(
                onPressed: () => prov.starSearch(context),
                icon: const Icon(
                  Icons.search,
                  color: Colors.black12,
                ),
              ),
          ],
        ),
        body: !prov.isComplet
            ? SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: prov.searchTextCotrollor.text.isEmpty
                        ? prov.allProfiles!.length
                        : prov.searchFonProfiles!.length,
                    itemBuilder: (ctx, index) {
                      prov.selectedItem[index] =
                          prov.selectedItem[index] ?? false;
                      bool? isSelectedData = prov.selectedItem[index];
                      return InkWell(
                        // onLongPress: () {
                        //   prov.itemSelection(index, isSelectedData);
                        // },
                        onTap: () {
                          prov.itemSelection(index, isSelectedData);
                        },
                        child: ProfileItemAddToConversation(
                          profile: prov.searchTextCotrollor.text.isEmpty
                              ? prov.allProfiles![index]
                              : prov.searchFonProfiles![index],
                          isSelected: isSelectedData!,
                        ),
                      );
                    }),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: prov.textTitleController,
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        fillColor: Colors.blue,
                        hintText: 'Put Title For Conversation...',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      //  onSubmitted: (){
                      //     prov.addtoConversation();
                      //   },
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            elevation: 2,
                            backgroundColor: Colors.amber),
                        onPressed: () {
                          prov.addtoConversation();
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              ConversationsPage.path,
                              (route) => false,
                            );
                          }
                        },
                        child: const Text("OK", style: TextStyle(fontSize: 25)))
                  ],
                ),
              ),
        floatingActionButton: prov.isSelectItem
            ? FloatingActionButton(
                onPressed: () {
                  prov.setCimplet();
                },
                tooltip: 'Next',
                child: const Icon(Icons.check),
              )
            : FloatingActionButton(
                onPressed: () {},
                tooltip: 'Go back!',
                child: const Text('back'),
              ));
  }
}
