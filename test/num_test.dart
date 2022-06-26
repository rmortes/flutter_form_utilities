import 'package:flutter_test/flutter_test.dart';
import 'package:form_utilities/validation.dart';
import 'package:form_utilities/validators/num_validator.dart';

void main() {
  group("Num validation", () {
    test("Rejects not num", () {
      final validator = validate([ValNum().eq(32)]);
      final result = validator("not num");
      expect(result, "Value must be a number");
    });
    test("Accepts correct num", () {
      final validator = validate([ValNum().eq(32)]);
      final result = validator("32");
      expect(result, null);
    });
    test("Accepts int", () {
      final validator = validate([ValNum().eq(32)]);
      final result = validator("32");
      expect(result, null);
    });
    test("Accepts double", () {
      final validator = validate([ValNum().eq(32.0)]);
      final result = validator("32.0");
      expect(result, null);
    });
    test("Does not reject float as int", () {
      final validator = validate([ValNum().eq(32.0)]);
      final result = validator("32");
      expect(result, null);
    });
    test("Does not reject int as float", () {
      final validator = validate([ValNum().eq(32)]);
      final result = validator("32.0");
      expect(result, null);
    });
    test("Gt works", () {
      final validator = validate([ValNum().gt(32)]);
      expect(validator("33"), null);
      expect(validator("32"), "Value must be greater than 32");
      expect(validator("31"), "Value must be greater than 32");
    });
    test("Lt works", () {
      final validator = validate([ValNum().lt(32)]);
      expect(validator("33"), "Value must be less than 32");
      expect(validator("32"), "Value must be less than 32");
      expect(validator("31"), null);
    });
    test("Gte works", () {
      final validator = validate([ValNum().gte(32)]);
      expect(validator("33"), null);
      expect(validator("32"), null);
      expect(validator("31"), "Value must be greater than or equal to 32");
    });
    test("Lte works", () {
      final validator = validate([ValNum().lte(32)]);
      expect(validator("33"), "Value must be less than or equal to 32");
      expect(validator("32"), null);
      expect(validator("31"), null);
    });
    test("Eq works", () {
      final validator = validate([ValNum().eq(32)]);
      expect(validator("33"), "Value must be equal to 32");
      expect(validator("32"), null);
      expect(validator("31"), "Value must be equal to 32");
    });
    test("Neq works", () {
      final validator = validate([ValNum().neq(32)]);
      expect(validator("33"), null);
      expect(validator("32"), "Value must not be equal to 32");
      expect(validator("31"), null);
    });
    test("Between works", () {
      final validator = validate([ValNum().between(32, 33)]);
      expect(validator("33"), null);
      expect(validator("32"), null);
      expect(validator("31"), "Value must be between 32 and 33");
    });
    test("Not between works", () {
      final validator = validate([ValNum().notBetween(32, 33)]);
      expect(validator("33"), "Value must not be between 32 and 33");
      expect(validator("32"), "Value must not be between 32 and 33");
      expect(validator("31"), null);
    });
    test("Is valid works", () {
      final validator = validate([ValNum().isValid()]);
      expect(validator("null"), "Value must be a number");
      expect(validator(""), "Value must be a number");
      expect(validator("0"), null);
    });
    test("Is not valid works", () {
      final validator = validate([ValNum().isNotValid()]);
      expect(validator("null"), null);
      expect(validator(""), null);
      expect(validator("0"), "Value must not be valid");
    });
    test("One of works", () {
      final validator = validate([
        ValNum().oneOf([1, 2, 3])
      ]);
      expect(validator("1"), null);
      expect(validator("2"), null);
      expect(validator("3"), null);
      expect(validator("4"), "Value must be one of 1, 2, 3");
    });
    test("Not one of works", () {
      final validator = validate([
        ValNum().notOneOf([1, 2, 3])
      ]);
      expect(validator("1"), "Value must not be one of 1, 2, 3");
      expect(validator("2"), "Value must not be one of 1, 2, 3");
      expect(validator("3"), "Value must not be one of 1, 2, 3");
      expect(validator("4"), null);
    });
    test("Is positive works", () {
      final validator = validate([ValNum().isPositive()]);
      expect(validator("0"), "Value must be positive");
      expect(validator("1"), null);
      expect(validator("-1"), "Value must be positive");
    });
    test("Is negative works", () {
      final validator = validate([ValNum().isNegative()]);
      expect(validator("0"), "Value must be negative");
      expect(validator("1"), "Value must be negative");
      expect(validator("-1"), null);
    });
  });
}
