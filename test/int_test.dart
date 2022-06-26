import 'package:flutter_test/flutter_test.dart';
import 'package:form_utilities/validation.dart';
import 'package:form_utilities/validators/num_validator.dart';

void main() {
  group("Int validation", () {
    test("Rejects not int", () {
      final validator = validate([ValInt().eq(32)]);
      final result = validator("not num");
      expect(result, "Value must be an integer");
    });
    test("Accepts int", () {
      final validator = validate([ValInt().eq(32)]);
      final result = validator("32");
      expect(result, null);
    });
    test("Rejects double", () {
      final validator = validate([ValInt().eq(32)]);
      final result = validator("32.0");
      expect(result, "Value must be an integer");
    });
    test("Gt works", () {
      final validator = validate([ValInt().gt(32)]);
      expect(validator("33"), null);
      expect(validator("32"), "Value must be greater than 32");
      expect(validator("31"), "Value must be greater than 32");
    });
    test("Lt works", () {
      final validator = validate([ValInt().lt(32)]);
      expect(validator("33"), "Value must be less than 32");
      expect(validator("32"), "Value must be less than 32");
      expect(validator("31"), null);
    });
    test("Gte works", () {
      final validator = validate([ValInt().gte(32)]);
      expect(validator("33"), null);
      expect(validator("32"), null);
      expect(validator("31"), "Value must be greater than or equal to 32");
    });
    test("Lte works", () {
      final validator = validate([ValInt().lte(32)]);
      expect(validator("33"), "Value must be less than or equal to 32");
      expect(validator("32"), null);
      expect(validator("31"), null);
    });
    test("Eq works", () {
      final validator = validate([ValInt().eq(32)]);
      expect(validator("33"), "Value must be equal to 32");
      expect(validator("32"), null);
      expect(validator("31"), "Value must be equal to 32");
    });
    test("Neq works", () {
      final validator = validate([ValInt().neq(32)]);
      expect(validator("33"), null);
      expect(validator("32"), "Value must not be equal to 32");
      expect(validator("31"), null);
    });
    test("Between works", () {
      final validator = validate([ValInt().between(32, 33)]);
      expect(validator("33"), null);
      expect(validator("32"), null);
      expect(validator("31"), "Value must be between 32 and 33");
    });
    test("Not between works", () {
      final validator = validate([ValInt().notBetween(32, 33)]);
      expect(validator("33"), "Value must not be between 32 and 33");
      expect(validator("32"), "Value must not be between 32 and 33");
      expect(validator("31"), null);
    });
    test("Is valid works", () {
      final validator = validate([ValInt().isValid()]);
      expect(validator("null"), "Value must be an integer");
      expect(validator(""), "Value must be an integer");
      expect(validator("0"), null);
    });
    test("Is not valid works", () {
      final validator = validate([ValInt().isNotValid()]);
      expect(validator("null"), null);
      expect(validator(""), null);
      expect(validator("0"), "Value must not be valid");
    });
    test("One of works", () {
      final validator = validate([
        ValInt().oneOf([1, 2, 3])
      ]);
      expect(validator("1"), null);
      expect(validator("2"), null);
      expect(validator("3"), null);
      expect(validator("4"), "Value must be one of 1, 2, 3");
    });
    test("Not one of works", () {
      final validator = validate([
        ValInt().notOneOf([1, 2, 3])
      ]);
      expect(validator("1"), "Value must not be one of 1, 2, 3");
      expect(validator("2"), "Value must not be one of 1, 2, 3");
      expect(validator("3"), "Value must not be one of 1, 2, 3");
      expect(validator("4"), null);
    });
    test("Is positive works", () {
      final validator = validate([ValInt().isPositive()]);
      expect(validator("0"), "Value must be positive");
      expect(validator("1"), null);
      expect(validator("-1"), "Value must be positive");
    });
    test("Is negative works", () {
      final validator = validate([ValInt().isNegative()]);
      expect(validator("0"), "Value must be negative");
      expect(validator("1"), "Value must be negative");
      expect(validator("-1"), null);
    });
  });
}
