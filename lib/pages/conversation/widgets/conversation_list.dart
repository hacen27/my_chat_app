import 'package:flutter/material.dart';
import 'package:my_chat_app/utils/constants.dart';
import 'package:timeago/timeago.dart';

class ConversationList extends StatelessWidget {
  final String name;
  final String messageText;
  final String title;
  final DateTime time;
  final void Function() onTap;
  final bool isMessageRead;
  const ConversationList({
    Key? key,
    required this.name,
    required this.messageText,
    required this.title,
    required this.time,
    required this.onTap,
    required this.isMessageRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(myUrlAvatar),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: isMessageRead
                                    ? FontWeight.w900
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              format(time, locale: 'en_short'),
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                  fontWeight:
                      isMessageRead ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
