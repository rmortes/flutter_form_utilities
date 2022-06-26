part of 'num_validator.dart';

class ValDouble extends NumValidator<double> {
  @override
  get invalidMessage => "Value must be a double";
  @override
  tryParse(String value) {
    if (int.tryParse(value) != null) {
      return null;
    }
    return double.tryParse(value);
  }

  @override
  Validator gt(gt) => (String value) => super._gt(value, gt);
  @override
  Validator lt(lt) => (String value) => super._lt(value, lt);

  @override
  Validator gte(gte) => (String value) => super._gte(value, gte);

  @override
  Validator lte(lte) => (String value) => super._lte(value, lte);

  @override
  Validator eq(eq) => (String value) => super._eq(value, eq);

  @override
  Validator neq(neq) => (String value) => super._neq(value, neq);

  @override
  Validator between(min, max) =>
      (String value) => super._between(value, min, max);

  @override
  Validator notBetween(min, max) =>
      (String value) => super._notBetween(value, min, max);

  @override
  Validator isNotValid() => (String value) => super._isNotValid(value);

  @override
  Validator isValid() => (String value) => super._isValid(value);

  @override
  Validator oneOf(List<double> oneOf) =>
      (String value) => super._oneOf(value, oneOf);

  @override
  Validator notOneOf(List<double> notOneOf) =>
      (String value) => super._notOneOf(value, notOneOf);

  @override
  Validator isNegative() => (String value) => super._isNegative(value);

  @override
  Validator isPositive() => (String value) => super._isPositive(value);
}
