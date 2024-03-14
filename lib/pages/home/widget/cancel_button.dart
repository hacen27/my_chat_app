import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback onTap;

  const CancelButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, top: 2),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      height: 36,
      width: 145,
      child: InkWell(
        onTap: onTap,
        child: const Center(
          child: Text(
            "Cancel",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
