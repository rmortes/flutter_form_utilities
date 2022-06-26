import 'package:flutter_test/flutter_test.dart';
import 'package:form_utilities/validation.dart';
import 'package:form_utilities/validators/num_validator.dart';
import 'package:form_utilities/validators/str_validator.dart';

void main() {
  group("Complex validators", () {
    test("OR can be used", () {
      // This validator will work for all positive integers that are not 0 or 5
      final validator = validate([
        ValInt().neq(0),
        ValInt().isPositive(),
        or([
          ValInt().lte(4),
          ValInt().gte(6),
        ])
      ]);
      expect(validator("0"), "Value must not be equal to 0");
      expect(validator("1"), null);
      expect(validator("2"), null);
      expect(validator("3"), null);
      expect(validator("4"), null);
      expect(validator("5"),
          "Value must be less than or equal to 4, Value must be greater than or equal to 6");
      expect(validator("6"), null);
      expect(validator("7"), null);
    });
    test("Either uppercase google, lowercase example, or a credit card number",
        () {
      final validator = validate([
        or([
          and([
            ValStr().isUppercase(),
            ValStr().isURL(
                protocols: ["HTTPS"],
                hostWhitelist: ["GOOGLE.COM"],
                requireTld: false)
          ]),
          and([
            ValStr().isLowercase(),
            ValStr().isURL(hostWhitelist: ["example.com"])
          ]),
          ValStr().isCreditCard(),
        ],
            error:
                'Value must be either "HTTPS://GOOGLE.COM", "http://example.com", or a valid credit card number')
      ]);
      expect(validator("HTTPS://GOOGLE.COM"), null);
      expect(validator("http://example.com"), null);
      expect(validator("4111111111111111"), null);
      expect(validator("4111111111111"),
          'Value must be either "HTTPS://GOOGLE.COM", "http://example.com", or a valid credit card number');
      expect(validator("hello world"),
          'Value must be either "HTTPS://GOOGLE.COM", "http://example.com", or a valid credit card number');
    });
  });
}
