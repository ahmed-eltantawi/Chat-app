import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String massage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.tertiary,

      content: Text(
        massage,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    ),
  );
}
