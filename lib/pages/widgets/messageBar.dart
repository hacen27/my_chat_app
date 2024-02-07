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
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  autofocus: true,
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: LocalizationsHelper.msgs(context).typeMessage,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              TextButton(
                onPressed: onSubmit,
                child: Text(LocalizationsHelper.msgs(context).sendMessage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class MessageBar extends StatefulWidget {
//   final String conversationId;
//   const MessageBar({
//     required this.conversationId,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<MessageBar> createState() => MessageBarState();
// }

// class MessageBarState extends State<MessageBar> {
//   late final TextEditingController _textController;

//   @override
//   void initState() {
//     _textController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.grey[200],
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   keyboardType: TextInputType.text,
//                   maxLines: null,
//                   autofocus: true,
//                   controller: _textController,
//                   decoration: InputDecoration(
//                     hintText: LocalizationsHelper.msgs(context).typeMessage,
//                     border: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                     contentPadding: const EdgeInsets.all(8),
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () => _submitMessage(widget.conversationId),
//                 child: Text(LocalizationsHelper.msgs(context).sendMessage),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _submitMessage(String conversationId) async {
//     final text = _textController.text;

//     if (text.isEmpty) {
//       return;
//     }

//     _textController.clear();

//     try {
//       final myId = supabase.auth.currentUser!.id;
//       final sendName = await supabase
//           .from('profile')
//           .select('username')
//           .eq('id', myId)
//           .single();

//       await supabase.from('message').insert({
//         'content': text,
//         'conversation_id': conversationId,
//         'send_id': myId,
//         'send_name': sendName['username'],
//       });
//     } on PostgrestException catch (error) {
//       ErrorSnackBar(message: error.message);
//     } catch (_) {
//       const ErrorSnackBar(message: unexpectedErrorMessage);
//     }
//   }
// }
