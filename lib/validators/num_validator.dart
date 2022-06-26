import 'package:form_utilities/validation.dart';

part 'val_num.dart';
part 'val_double.dart';
part 'val_int.dart';

abstract class NumValidator<T extends num> {
  T? tryParse(String value);
  Validator gt(T gt);
  Validator lt(T lt);
  Validator gte(T gte);
  Validator lte(T lte);
  Validator eq(T eq);
  Validator neq(T neq);
  Validator between(T min, T max);
  Validator notBetween(T min, T max);
  Validator oneOf(List<T> oneOf);
  Validator notOneOf(List<T> notOneOf);
  Validator isValid();
  Validator isNotValid();
  Validator isPositive();
  Validator isNegative();
  String get invalidMessage;

  String? _gt(String value, T gt, {String? error}) {
    final parsedValue = tryParse(value);
    if (parsedValue == null) return error ?? invalidMessage;
    return parsedValue > gt ? null : error ?? 'Value must be greater than $gt';
  }

  String? _lt(String value, T lt, {String? error}) {
    final parsedValue = tryParse(value);
    if (parsedValue == null) return error ?? invalidMessage;
    return parsedValue < lt ? null : error ?? 'Value must be less than $lt';
  }

  String? _gte(String value, T gte, {String? error}) {
    final parsedValue = tryParse(value);
    if (parsedValue == null) return error ?? invalidMessage;
    return parsedValue >= gte
        ? null
        : error ?? 'Value must be greater than or equal to $gte';
  }

  String? _lte(String value, T lte, {String? error}) {
    final parsedValue = tryParse(value);
    if (parsedValue == null) return error ?? invalidMessage;
    return parsedValue <= lte
        ? null
        : error ?? 'Value must be less than or equal to $lte';
  }

  String? _eq(String value, T eq, {String? error}) {
    final parsedValue = tryParse(value);
    if (parsedValue == null) return error ?? invalidMessage;
    return parsedValue == eq ? null : error ?? 'Value must be equal to $eq';
  }

  String? _neq(String value, T eq, {String? error}) {
    final neq = _eq(value, eq) == null;
    return neq ? error ?? 'Value must not be equal to $eq' : null;
  }

  String? _between(String value, T min, T max, {String? error}) {
    final parsedValue = tryParse(value);
    if (parsedValue == null) return error ?? invalidMessage;
    return parsedValue >= min && parsedValue <= max
        ? null
        : error ?? 'Value must be between $min and $max';
  }

  String? _notBetween(String value, T min, T max, {String? error}) {
    final notBetween = _between(value, min, max) == null;
    return notBetween
        ? error ?? 'Value must not be between $min and $max'
        : null;
  }

  String? _oneOf(String value, List<T> oneOf, {String? error}) {
    final parsedValue = tryParse(value);
    if (parsedValue == null) return error ?? invalidMessage;
    return oneOf.contains(parsedValue)
        ? null
        : error ?? 'Value must be one of ${oneOf.join(", ")}';
  }

  String? _notOneOf(String value, List<T> oneOf, {String? error}) {
    final notOneOf = _oneOf(value, oneOf) == null;
    return notOneOf
        ? error ?? 'Value must not be one of ${oneOf.join(", ")}'
        : null;
  }

  String? _isValid(String value, {String? error}) {
    final parsedValue = tryParse(value);
    if (parsedValue == null) return error ?? invalidMessage;
    return null;
  }

  String? _isNotValid(String value, {String? error}) {
    final isNotValid = _isValid(value) == null;
    return isNotValid ? error ?? 'Value must not be valid' : null;
  }

  String? _isPositive(String value, {String? error}) {
    final parsedValue = tryParse(value);
    if (parsedValue == null) return error ?? invalidMessage;
    return parsedValue > 0 ? null : error ?? 'Value must be positive';
  }

  String? _isNegative(String value, {String? error}) {
    final parsedValue = tryParse(value);
    if (parsedValue == null) return error ?? invalidMessage;
    return parsedValue < 0 ? null : error ?? 'Value must be negative';
  }
}
