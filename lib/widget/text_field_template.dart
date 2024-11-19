import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldTemplate extends StatelessWidget {
  const TextFieldTemplate({super.key, this.onChange, this.initValue, this.onSubmitted, this.inputFormatters});

  final Function(String)? onChange;

  final Function(String)? onSubmitted;

  final String? initValue;

  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      onFieldSubmitted: onSubmitted,
      initialValue: initValue,
      inputFormatters: inputFormatters,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0))),
    );
  }
}
