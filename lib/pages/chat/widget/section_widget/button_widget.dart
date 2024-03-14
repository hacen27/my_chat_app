import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? myIcon;
  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.myIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11, right: 13, top: 5, bottom: 5),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            myIcon != null
                ? Icon(
                    myIcon!,
                    color: const Color.fromARGB(221, 8, 8, 8),
                    size: 16,
                  )
                : const Icon(Icons.abc_outlined, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}
