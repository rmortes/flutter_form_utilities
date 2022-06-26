part of 'num_validator.dart';

class ValNum extends NumValidator<num> {
  @override
  get invalidMessage => "Value must be a number";
  @override
  tryParse(String value) => num.tryParse(value);

  @override
  Validator gt(gt, {String? error}) =>
      (String value) => super._gt(value, gt, error: error);
  @override
  Validator lt(lt, {String? error}) =>
      (String value) => super._lt(value, lt, error: error);

  @override
  Validator gte(gte, {String? error}) =>
      (String value) => super._gte(value, gte, error: error);

  @override
  Validator lte(lte, {String? error}) =>
      (String value) => super._lte(value, lte, error: error);

  @override
  Validator eq(eq, {String? error}) =>
      (String value) => super._eq(value, eq, error: error);

  @override
  Validator neq(neq, {String? error}) =>
      (String value) => super._neq(value, neq, error: error);

  @override
  Validator between(min, max, {String? error}) =>
      (String value) => super._between(value, min, max, error: error);

  @override
  Validator notBetween(min, max, {String? error}) =>
      (String value) => super._notBetween(value, min, max, error: error);

  @override
  Validator isNotValid({String? error}) =>
      (String value) => super._isNotValid(value, error: error);

  @override
  Validator isValid({String? error}) =>
      (String value) => super._isValid(value, error: error);

  @override
  Validator oneOf(List<num> oneOf, {String? error}) =>
      (String value) => super._oneOf(value, oneOf, error: error);

  @override
  Validator notOneOf(List<num> notOneOf, {String? error}) =>
      (String value) => super._notOneOf(value, notOneOf, error: error);

  @override
  Validator isNegative({String? error}) =>
      (String value) => super._isNegative(value, error: error);

  @override
  Validator isPositive({String? error}) =>
      (String value) => super._isPositive(value, error: error);
}
