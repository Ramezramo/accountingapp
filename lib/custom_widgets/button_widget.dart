import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  final Function()? onPressed;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      onPressed: onPressed,
      label: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .apply(color: Theme.of(context).colorScheme.secondary),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
      ),
    );
  }
}
