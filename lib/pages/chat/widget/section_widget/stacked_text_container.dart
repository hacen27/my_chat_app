import 'package:flutter/material.dart';

class StackedTextContainer extends StatelessWidget {
  final String topText;
  final String bottomText;

  const StackedTextContainer(
      {Key? key, required this.topText, required this.bottomText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        padding:
            const EdgeInsets.only(left: 10.0, right: 30.0, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: topText,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                    ),
              ),
              TextSpan(
                text: "\n$bottomText",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      height: 0.7,
                      fontSize: 15,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
