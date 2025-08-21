import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Provide the base form field to easy handle with value notifier
// ignore: must_be_immutable
class BaseTextFormField<T> extends StatelessWidget {
  BaseTextFormField({
    super.key,
    required this.value,
    this.converter,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.decoration,
    this.label = "",
    this.hint = "",
    this.errorText,
    this.valildator,
    this.inputFormatters,
    this.helperText,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.start,
    this.style,
    this.autofocus = false,
  }) {
    // Controller
    controller ??= TextEditingController(
      text: converter == null
          ? value.value.toString()
          : converter!.fromValue(value.value),
    );
    // Listen value change from outside
    value.addListener(outsideTextChangesListener);

    // Decoration
    decoration ??= InputDecoration(
      labelText: label,
      hintText: hint,
      errorText: errorText,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

  final ValueNotifier<T?> value;
  late TextEditingController? controller;
  final TextInputType keyboardType;
  InputDecoration? decoration;
  final Converter? converter;
  final String label;
  final String hint;
  final String? errorText;
  final FormFieldValidator<String?>? valildator;
  final List<TextInputFormatter>? inputFormatters;
  final String? helperText;
  final bool readOnly;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final TextStyle? style;
  final bool autofocus;

  /// Listen text change from the outside
  void outsideTextChangesListener() {
    controller?.value = converter == null
        ? TextEditingValue(text: value.value.toString())
        : TextEditingValue(text: converter!.fromValue(value.value));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autofocus: autofocus,
      decoration: decoration,
      onChanged: (newValue) {
        // Remove outside lister first
        value.removeListener(outsideTextChangesListener);
        // Update value
        try {
          value.value = converter == null
              ? newValue
              : converter!.toValue(newValue);
        } catch (e) {
          throw Exception(
            "Please, provide `converter` property to convert value from string to ${T.toString()}",
          );
        }
        // Add listener back when value updated
        value.addListener(outsideTextChangesListener);
      },
      validator: valildator,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      enabled: enabled,
      textAlign: textAlign,
      style: style,
    );
  }
}

class Converter<T> {
  Converter({required this.fromValue, required this.toValue});
  final String Function(T value) fromValue;
  T Function(String? value) toValue;
}
