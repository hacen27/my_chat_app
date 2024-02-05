import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final String title;

  const ProfileItem({
    Key? key,
    required this.title,
  }) : super(key: key);

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
              child: Text(
                style: TextStyle(color: Colors.white),
                (title.toUpperCase().substring(0, 1)),
              ),
            ),
            Text(title),
          ]),
        ],
      ),
    );
  }
}
