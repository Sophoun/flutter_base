import 'package:flutter/material.dart';

/// Provide the base form field to easy handle with value notifier
// ignore: must_be_immutable
class BaseTextFormField<T> extends StatelessWidget {
  BaseTextFormField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.converter,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.decoration,
    this.label = "",
    this.hint = "",
    this.errorText,
    this.valildator,
  }) {
    controller ??= TextEditingController(
      text: converter == null
          ? value.value.toString()
          : converter!.fromValue(value.value),
    );
    decoration ??= InputDecoration(
      border: OutlineInputBorder(),
      labelText: label,
      hintText: hint,
      errorText: errorText,
    );
  }

  final ValueNotifier<T?> value;
  final Function(T? value) onChanged;
  late TextEditingController? controller;
  final TextInputType keyboardType;
  InputDecoration? decoration;
  final Converter? converter;
  final String label;
  final String hint;
  final String? errorText;
  final FormFieldValidator<String?>? valildator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autofocus: true,
      decoration: decoration,
      onChanged: (value) {
        onChanged(converter == null ? value : converter!.toValue(value));
      },
      validator: valildator,
    );
  }
}

class Converter<T> {
  Converter({required this.fromValue, required this.toValue});
  final String Function(T value) fromValue;
  T Function(String? value) toValue;
}
