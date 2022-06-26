import 'package:flutter_test/flutter_test.dart';
import 'package:form_utilities/validation.dart';
import 'package:form_utilities/validators/num_validator.dart';

void main() {
  group("Double validation", () {
    test("Rejects not double", () {
      final validator = validate([ValDouble().eq(32)]);
      final result = validator("not num");
      expect(result, "Value must be a double");
    });
    test("Rejects int", () {
      final validator = validate([ValDouble().eq(32)]);
      final result = validator("32");
      expect(result, "Value must be a double");
    });
    test("Accepts double", () {
      final validator = validate([ValDouble().eq(32)]);
      final result = validator("32.0");
      expect(result, null);
    });
    test("Gt works", () {
      final validator = validate([ValDouble().gt(32)]);
      expect(validator("33.0"), null);
      expect(validator("32.0"), "Value must be greater than 32.0");
      expect(validator("31.0"), "Value must be greater than 32.0");
    });
    test("Lt works", () {
      final validator = validate([ValDouble().lt(32)]);
      expect(validator("33.0"), "Value must be less than 32.0");
      expect(validator("32.0"), "Value must be less than 32.0");
      expect(validator("31.0"), null);
    });
    test("Gte works", () {
      final validator = validate([ValDouble().gte(32)]);
      expect(validator("33.0"), null);
      expect(validator("32.0"), null);
      expect(validator("31.0"), "Value must be greater than or equal to 32.0");
    });
    test("Lte works", () {
      final validator = validate([ValDouble().lte(32)]);
      expect(validator("33.0"), "Value must be less than or equal to 32.0");
      expect(validator("32.0"), null);
      expect(validator("31.0"), null);
    });
    test("Eq works", () {
      final validator = validate([ValDouble().eq(32)]);
      expect(validator("33.0"), "Value must be equal to 32.0");
      expect(validator("32.0"), null);
      expect(validator("31.0"), "Value must be equal to 32.0");
    });
    test("Neq works", () {
      final validator = validate([ValDouble().neq(32)]);
      expect(validator("33.0"), null);
      expect(validator("32.0"), "Value must not be equal to 32.0");
      expect(validator("31.0"), null);
    });
    test("Between works", () {
      final validator = validate([ValDouble().between(32, 33)]);
      expect(validator("33.0"), null);
      expect(validator("32.0"), null);
      expect(validator("31.0"), "Value must be between 32.0 and 33.0");
    });
    test("Not between works", () {
      final validator = validate([ValDouble().notBetween(32, 33)]);
      expect(validator("33.0"), "Value must not be between 32.0 and 33.0");
      expect(validator("32.0"), "Value must not be between 32.0 and 33.0");
      expect(validator("31.0"), null);
    });
    test("Is valid works", () {
      final validator = validate([ValDouble().isValid()]);
      expect(validator("null"), "Value must be a double");
      expect(validator(""), "Value must be a double");
      expect(validator("0"), "Value must be a double");
      expect(validator("0.0"), null);
    });
    test("Is not valid works", () {
      final validator = validate([ValDouble().isNotValid()]);
      expect(validator("null"), null);
      expect(validator(""), null);
      expect(validator("0"), null);
      expect(validator("0.0"), "Value must not be valid");
    });
    test("One of works", () {
      final validator = validate([
        ValDouble().oneOf([1, 2, 3])
      ]);
      expect(validator("1.0"), null);
      expect(validator("2.0"), null);
      expect(validator("3.0"), null);
      expect(validator("4.0"), "Value must be one of 1.0, 2.0, 3.0");
    });
    test("Not one of works", () {
      final validator = validate([
        ValDouble().notOneOf([1, 2, 3])
      ]);
      expect(validator("1.0"), "Value must not be one of 1.0, 2.0, 3.0");
      expect(validator("2.0"), "Value must not be one of 1.0, 2.0, 3.0");
      expect(validator("3.0"), "Value must not be one of 1.0, 2.0, 3.0");
      expect(validator("4.0"), null);
    });
    test("Is positive works", () {
      final validator = validate([ValDouble().isPositive()]);
      expect(validator("0.0"), "Value must be positive");
      expect(validator("1.0"), null);
      expect(validator("-1.0"), "Value must be positive");
    });
    test("Is negative works", () {
      final validator = validate([ValDouble().isNegative()]);
      expect(validator("0.0"), "Value must be negative");
      expect(validator("1.0"), "Value must be negative");
      expect(validator("-1.0"), null);
    });
  });
}
