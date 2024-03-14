import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_chat_app/models/message.dart';
import 'package:my_chat_app/pages/chat/widget/section_widget/reaction_row_item.dart';
import 'package:my_chat_app/pages/chat/widget/section_widget/stacked_text_container.dart';
import 'package:my_chat_app/pages/chat/widget/section_widget/button_widget.dart';
import 'package:my_chat_app/pages/chat/widget/reply_message_widget.dart';
import 'package:my_chat_app/services/chat_services.dart';
import 'package:my_chat_app/utils/constants.dart';
import 'package:my_chat_app/utils/exception_catch.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final ChatServices _chatServices = ChatServices();
  MessageWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(12);
    const borderRadius = BorderRadius.all(radius);
    final width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment:
          message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!message.isMine)
          CircleAvatar(radius: 16, backgroundImage: NetworkImage(myUrlAvatar)),
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(13),
          constraints: BoxConstraints(maxWidth: width * 3 / 4),
          decoration: BoxDecoration(
            color: message.isMine
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[300],
            borderRadius: message.isMine
                ? borderRadius
                    .subtract(const BorderRadius.only(bottomRight: radius))
                : borderRadius
                    .subtract(const BorderRadius.only(bottomLeft: radius)),
          ),
          child: InkWell(
              onTap: () {
                _showDataBottomSheet(context);
              },
              child: buildMessage()),
        ),
      ],
    );
  }

  Widget buildMessage() {
    final messageWidget = Text(message.content);

    if (message.replyMessage == null) {
      return messageWidget;
    } else {
      return Column(
        crossAxisAlignment: message.isMine && message.replyMessage == null
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          buildReplyMessage(),
          messageWidget,
        ],
      );
    }
  }

  Widget buildReplyMessage() {
    final replyMessage = message.replyMessage;
    final isReplying = replyMessage != null;

    if (!isReplying) {
      return Container();
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: ReplyMessageWidget(
          message: replyMessage,
        ),
      );
    }
  }

  void _showDataBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(
        minHeight: 200,
        maxHeight: double.infinity,
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.only(left: 18, right: 18, bottom: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 4,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  ),
                ),
              ),
              const StackedTextContainer(
                topText: "Please help me find a good monitor for",
                bottomText: "\nthe design",
              ),
              const SizedBox(
                height: 15,
              ),
              ReactionRowItem(
                title: 'React',
                children: [
                  Text("🔥",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28)),
                  Text("🙌",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28)),
                  Text("😅",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28)),
                  Text(
                    "😇",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 28),
                  ),
                  Text("🥪",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28)),
                  Text("🎉",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28)),
                  Text("🙁",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28)),
                  Text("😇",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28)),
                  Text("😎",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28)),
                  Text("😇",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28)),
                  Text("😎",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 11, right: 11),
                child: Divider(),
              ),
              ButtonWidget(
                onPressed: () async {
                  copyToClipboard(message.content);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                text: 'Copy',
                myIcon: Icons.copy_outlined,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 11, right: 11),
                child: Divider(),
              ),
              ButtonWidget(
                onPressed: () {},
                text: 'Reply',
                myIcon: Icons.reply_outlined,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 11, right: 11),
                child: Divider(),
              ),
              ButtonWidget(
                onPressed: () {},
                text: 'Forward',
                myIcon: Icons.redo_outlined,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 11, right: 11),
                child: Divider(),
              ),
              ButtonWidget(
                onPressed: () async {
                  await ExceptionCatch.catchErrors(
                      () => _chatServices.deleteMessage(message.content));
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                text: 'Delete',
                myIcon: Icons.delete_outline,
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        );
      },
    );
  }

  Future<void> copyToClipboard(String text) async {
    final clipboard = ClipboardData(text: text);
    await Clipboard.setData(clipboard);
  }
}
