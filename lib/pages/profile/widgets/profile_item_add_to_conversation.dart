import 'package:flutter/material.dart';
import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/utils/constants.dart';

class ProfileItemAddToConversation extends StatelessWidget {
  final Profile? profile;

  final bool isSelected;

  const ProfileItemAddToConversation({
    Key? key,
    required this.profile,
    this.isSelected = false,
  }) : super(key: key);

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
                  backgroundImage: NetworkImage(myUrlAvatar),
                ),
              Text(
                profile!.username,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
