import 'package:flutter/material.dart';

import 'package:my_chat_app/pages/conversation/conversations_page.dart';
import 'package:my_chat_app/pages/home/widget/cancel_button.dart';
import 'package:my_chat_app/pages/home/widget/new_chat_button.dart';
import 'package:my_chat_app/pages/profile/profiles_page.dart';
import 'package:my_chat_app/pages/home/widget/section_widget.dart';
import 'package:my_chat_app/pages/home/widget/settings_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/conversations_provider.dart';

class HomePage extends StatelessWidget {
  static const path = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ConversationProvider(), child: const _HomePage());
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final List<Widget> _mainContents = [
    const ConversationsPage(),
    const SettingsWidget(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: NewChatButton(
        onPressed: () => showDataBottomSheet(context),
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.indigoAccent,
              elevation: 10,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat_bubble), label: 'Discussions'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings')
                ])
          : null,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              minWidth: 55.0,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: const TextStyle(
                color: Colors.amber,
              ),
              leading: const Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                ],
              ),
              unselectedLabelTextStyle: const TextStyle(),
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.chat_bubble), label: Text('Discussions')),
                NavigationRailDestination(
                    icon: Icon(Icons.settings), label: Text('Settings')),
              ],
            ),
          Expanded(child: _mainContents[_selectedIndex]),
        ],
      ),
    );
  }

  void showDataBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(13.0),
            margin:
                const EdgeInsets.only(bottom: 8, top: 16, left: 17, right: 17),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SectionWidget(
                  icon: Icons.chat_outlined,
                  title: 'New Chat',
                  subtitle: 'Create new conversation and send message',
                  onTap: () async {
                    Navigator.pushNamed(context, ProfilesPage.path);
                  },
                ),
                const Divider(),
                SectionWidget(
                  icon: Icons.perm_contact_cal_outlined,
                  title: 'New Contact',
                  subtitle: 'Add contact in list conversations',
                  onTap: () => Navigator.pop(context),
                ),
                const Divider(),
                SectionWidget(
                  icon: Icons.people_outline_sharp,
                  title: 'New Community',
                  subtitle: 'Join the community around you',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          CancelButton(
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
