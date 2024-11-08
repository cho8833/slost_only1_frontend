import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({super.key, this.onChange, this.initValue, this.onSubmitted});

  final Function(String)? onChange;

  final Function(String)? onSubmitted;

  final String? initValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      onFieldSubmitted: onSubmitted,
      initialValue: initValue,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0))),
    );
  }
}
