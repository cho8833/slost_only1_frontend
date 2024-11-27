import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldTemplate extends StatelessWidget {
  const TextFieldTemplate({super.key, this.onChange, this.initValue, this.onSubmitted, this.inputFormatters, this.hint});

  final Function(String)? onChange;

  final Function(String)? onSubmitted;

  final String? initValue;

  final List<TextInputFormatter>? inputFormatters;

  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      onFieldSubmitted: onSubmitted,
      initialValue: initValue,
      inputFormatters: inputFormatters,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: hint,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0))),
    );
  }
}
