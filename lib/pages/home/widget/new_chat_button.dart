import 'package:flutter/material.dart';

class NewChatButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NewChatButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      height: 33.0,
      width: 120.0,
      child: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 1.0,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 18.0,
            ),
            SizedBox(width: 5.0), // Add spacing between icon and text
            Text(
              "New Chat",
              style: TextStyle(color: Colors.white, fontSize: 13.5),
            ),
          ],
        ),
      ),
    );
  }
}
