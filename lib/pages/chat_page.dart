import 'package:flutter/material.dart';

import 'package:my_chat_app/pages/coversationdetails.dart';
import 'package:my_chat_app/pages/accounts/register_page.dart';
import 'package:my_chat_app/pages/widgets/chatbubble.dart';
import 'package:my_chat_app/pages/widgets/messagebar.dart';
import 'package:my_chat_app/providers/chat_provider.dart';
import 'package:my_chat_app/utils/supabase_constants.dart';
import 'package:provider/provider.dart';

import '../utils/localizations_helper.dart';

class ChatPage extends StatefulWidget {
  static const path = "/chat";

  const ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Arguments arguments;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arguments = ModalRoute.of(context)!.settings.arguments as Arguments;
  }

  @override
  Widget build(BuildContext context) {
    final id = arguments.id;
    final title = arguments.title;
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(conversationId: id),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: TextButton(
            onPressed: () async {
              Navigator.pushNamed(context, ConversationDetails.path,
                  arguments: Arguments(id: id, title: title));
            },
            child: Text(title),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await supabase.auth.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushNamedAndRemoveUntil(
                    context, RegisterPage.path, (route) => false);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
        body: Consumer<ChatProvider?>(builder: (context, chtPro, child) {
          if (chtPro == null) {
            return const Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 20, 65, 190)));
          } else {
            return Column(
              children: [
                Expanded(
                  child: chtPro.messages.isEmpty
                      ? Center(
                          child: Text(LocalizationsHelper.msgs(context)
                              .startConversation),
                        )
                      : ListView.builder(
                          reverse: true,
                          itemCount: chtPro.messages.length,
                          itemBuilder: (context, index) {
                            final message = chtPro.messages[index];

                            return ChatBubble(
                              message: message,
                            );
                          },
                        ),
                ),
                MessageBar(
                  textController: chtPro.textController,
                  onSubmit: () {
                    chtPro.submitMessage(context);
                  },
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}

class Arguments {
  String id;
  String title;
  Arguments({required this.id, required this.title});
}
