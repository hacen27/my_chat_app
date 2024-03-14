import 'package:flutter/material.dart';

class ReactionRowItem extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ReactionRowItem({Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 11,
            right: 8,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 0, top: 7, bottom: 7),
          child: SizedBox(
            height: 35.0,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: children.length,
              separatorBuilder: (context, index) => const SizedBox(width: 15.0),
              itemBuilder: (context, index) => children[index],
            ),
          ),
        ),
      ],
    );
  }
}
