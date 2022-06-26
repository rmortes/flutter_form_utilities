import 'package:flutter/material.dart';
import 'package:form_utilities/validation.dart';
import 'package:form_utilities/validators/num_validator.dart';
import 'package:form_utilities/validators/str_validator.dart';

class AgeFormField extends StatelessWidget {
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

  final int? min;
  final int? max;

  final TextEditingController? controller;

  AgeFormField({
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
    this.min,
    this.max,
    this.controller,
  })  : assert(!(validators.isNotEmpty && validator != null),
            "The validators will be shadowed by the validator function"),
        super(key: key);

  late final _defaultValidators = [
    ValInt().isValid(error: "The age must be a whole number"),
    ValInt().isPositive(error: "The age must be positive"),
    if (min != null && max != null)
      ValInt()
          .between(min!, max!, error: "The age must be between $min and $max"),
    if (min != null && max == null)
      ValInt().gt(min!, error: "The age must be greater than $min"),
    if (min == null && max != null)
      ValInt().lt(max!, error: "The age must be less than $max"),
  ];

  InputDecoration get _decoration =>
      decoration ??
      InputDecoration(
          labelText: label ?? "Age",
          hintText: hint,
          helperText: helper,
          prefixText: prefix,
          suffixText: suffix ?? "Years");

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
      keyboardType: TextInputType.number,
    );
  }
}
