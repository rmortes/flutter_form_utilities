import 'package:flutter/material.dart';
import 'package:form_utilities/validation.dart';
import 'package:form_utilities/validators/str_validator.dart';

class EmailFormField extends StatelessWidget {
  /// If this function is defined, it will override the default validators.
  final ValidatorFunction? validator;

  /// List of validators to be appended to the default validators of the field.
  final List<Validator> validators;

  /// If this value is false, the default validators won't be applied
  final bool useDefaultValidators;

  final String? label;
  final String? hint;
  final String? helper;
  final String? prefix;
  final String? suffix;
  final InputDecoration? decoration;

  final AutovalidateMode autovalidateMode;

  final TextEditingController? controller;

  EmailFormField({
    Key? key,
    this.validator,
    this.validators = const [],
    this.label,
    this.hint,
    this.helper,
    this.prefix,
    this.suffix,
    this.decoration,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.useDefaultValidators = true,
    this.controller,
  })  : assert(!(validators.isNotEmpty && validator != null),
            "The validators will be shadowed by the validator function"),
        super(key: key);

  final _defaultValidators = [
    ValStr().isNotEmpty(error: "The email can't be empty"),
    ValStr().isEmail(error: "The email must be valid"),
  ];

  InputDecoration get _decoration =>
      decoration ??
      InputDecoration(
          labelText: label ?? "Email",
          hintText: hint,
          helperText: helper,
          prefixText: prefix,
          suffixText: suffix);

  ValidatorFunction get _validator => (val) =>
      validator?.call(val) ??
      validate([
        if (useDefaultValidators) ..._defaultValidators,
        ...validators
      ])(val);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: _decoration,
      validator: _validator,
      controller: controller,
      autovalidateMode: autovalidateMode,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
