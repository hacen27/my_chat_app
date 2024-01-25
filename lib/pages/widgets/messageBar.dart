import 'package:flutter/material.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../utils/constants.dart';

class MessageBar extends StatefulWidget {
  String conversationId;
  MessageBar({
    required this.conversationId,
    Key? key,
  }) : super(key: key);

  @override
  State<MessageBar> createState() => MessageBarState();
}

class MessageBarState extends State<MessageBar> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  autofocus: true,
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: LocalizationsHelper.msgs(context).typeMessage,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _submitMessage(widget.conversationId),
                child: Text(LocalizationsHelper.msgs(context).sendMessage),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitMessage(String conversationId) async {
    final text = _textController.text;

    if (text.isEmpty) {
      return;
    }

    _textController.clear();

    try {
      final myId = supabase.auth.currentUser!.id;
      await supabase.from('message').insert({
        'content': text,
        'conversation_id': conversationId,
        'send_id': myId,
      });
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (_) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }
}

// Assurez-vous d'avoir la classe LocalizationsHelper définie ailleurs dans votre code.
