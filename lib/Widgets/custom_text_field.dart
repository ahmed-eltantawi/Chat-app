import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.hide = false,
  });
  final String hintText;
  final Function(String)? onChanged;
  final bool hide;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).colorScheme.primary,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        obscureText: hide,
        validator: (value) {
          if (value!.isEmpty) {
            return "Field is required";
          }
          return null;
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.inversePrimary,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.only(left: 15),
          hint: Text(
            hintText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
