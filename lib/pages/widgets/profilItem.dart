import 'package:flutter/material.dart';
import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/pages/chat_page.dart';

class ProfileItem extends StatelessWidget {
  final Profile? profile;
  final String? conversationId;
  const ProfileItem({Key? key, required this.profile, this.conversationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CircleAvatar(
              radius: 30,
              child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ChatPage.path,
                        arguments: conversationId);
                  },
                  child: Text(
                    style: TextStyle(color: Colors.white),
                    (profile!.username.toUpperCase().substring(0, 1)),
                  )),
            ),
            Text(profile!.username),
          ]),
        ],
      ),
    );
  }
}
