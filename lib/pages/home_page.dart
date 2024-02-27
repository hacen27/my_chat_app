import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:my_chat_app/pages/widgets/settings_widget.dart';

class HomePage extends StatefulWidget {
  static const path = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _mainContents = [
    const ConversationsPage(),
    Container(
      color: Colors.red.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Appels',
        style: TextStyle(fontSize: 40),
      ),
    ),
    SettingsWidget()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.indigoAccent,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat_bubble), label: 'Discussions'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.call), label: 'Appels'),
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
                    icon: Icon(Icons.call), label: Text('Appels')),
                NavigationRailDestination(
                    icon: Icon(Icons.settings), label: Text('Settings')),
              ],
            ),
          Expanded(child: _mainContents[_selectedIndex]),
        ],
      ),
    );
  }
}
