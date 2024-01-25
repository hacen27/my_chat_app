import 'package:flutter/material.dart';
import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/pages/conversations_page.dart';

class ProfileItemAddToConversation extends StatelessWidget {
  late Profile? profile;
  void Function()? newConversation;
  ProfileItemAddToConversation(
      {Key? key, required this.profile, required this.newConversation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CircleAvatar(
              radius: 30,
              child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    newConversation?.call();
                    Navigator.pushNamedAndRemoveUntil(
                        context, ConversationsPage.path, (route) => false);
                  },
                  child: Text(
                    style: const TextStyle(color: Colors.white),
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
