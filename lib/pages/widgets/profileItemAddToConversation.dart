import 'package:flutter/material.dart';
import 'package:my_chat_app/models/profile.dart';

class ProfileItemAddToConversation extends StatelessWidget {
  late Profile? profile;
  Future<void> Function()? newConversation;
  final bool isSelected;
  ProfileItemAddToConversation(
      {Key? key,
      required this.profile,
      this.newConversation,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isSelected)
                Icon(Icons.check_box, color: Theme.of(context).primaryColor)
              else
                CircleAvatar(
                  radius: 30,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {},
                    child: Text(
                      profile!.username.toUpperCase().substring(0, 1),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              Text(profile!.username),
            ],
          )
        ],
      ),
    );
  }
}
