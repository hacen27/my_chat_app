import 'package:flutter/material.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';

class MessageBar extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSubmit;

  const MessageBar({
    Key? key,
    required this.textController,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: LocalizationsHelper.msgs(context).typeMessage,
                    counterStyle: const TextStyle(fontSize: 15),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onSubmit,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
