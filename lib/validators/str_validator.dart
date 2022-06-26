import 'package:form_utilities/validation.dart';
import 'package:validators/validators.dart' as val;

enum IPVersion {
  ipV4(4),
  ipV6(6);

  final int version;

  const IPVersion(this.version);
}

enum UUIDVersion {
  uuid3(3),
  uuid4(4),
  uuid5(5);

  final int version;

  const UUIDVersion(this.version);
}

enum ISBNVersion {
  isbnV10(10),
  isbnV13(13);

  final int version;

  const ISBNVersion(this.version);
}

class ValStr {
  Validator contains(String contains) => (str) =>
      val.contains(str, contains) ? null : "Value must contain $contains";
  Validator notContains(String notContains) =>
      (str) => val.contains(str, notContains)
          ? "Value must not contain $notContains"
          : null;

  Validator startsWith(String startsWith) => (str) =>
      str.startsWith(startsWith) ? null : "Value must start with $startsWith";
  Validator notStartsWith(String notStartsWith) =>
      (str) => str.startsWith(notStartsWith)
          ? "Value must not start with $notStartsWith"
          : null;
  Validator endsWith(String endsWith) =>
      (str) => str.endsWith(endsWith) ? null : "Value must end with $endsWith";
  Validator notEndsWith(String notEndsWith) => (str) =>
      str.endsWith(notEndsWith) ? "Value must not end with $notEndsWith" : null;
  Validator eq(String eq) => (String value) =>
      val.equals(value, eq) ? null : "Value must be equal to $eq";
  Validator neq(String neq) => (String value) =>
      val.equals(value, neq) ? "Value must not be equal to $neq" : null;
  Validator isAlpha() => (String value) => val.isAlpha(value)
      ? null
      : "Value must only contain upper and lowercase letters";
  Validator isNotAlpha() => (String value) => val.isAlpha(value)
      ? "Value must not only contain upper or lowercase letters"
      : null;
  Validator isAlphanumeric() => (String value) => val.isAlphanumeric(value)
      ? null
      : "Value must only contain letters and numbers";
  Validator isNotAlphanumeric() => (String value) => val.isAlphanumeric(value)
      ? "Value must not only contain letters or numbers"
      : null;
  Validator isAscii() => (String value) =>
      val.isAscii(value) ? null : "Value must only contain ASCII characters";
  Validator isNotAscii() => (String value) => val.isAscii(value)
      ? "Value must not only contain ASCII characters"
      : null;
  Validator isBase64() => (String value) =>
      val.isBase64(value) ? null : "Value must be a base64 string";
  Validator isNotBase64() => (String value) =>
      val.isBase64(value) ? "Value must not be a base64 string" : null;
  Validator byteLengthBetween(int min, int max) =>
      (String value) => val.isByteLength(value, min, max)
          ? null
          : "Value must be between $min and $max bytes";
  Validator byteLengthNotBetween(int min, int max) =>
      (String value) => val.isByteLength(value, min, max)
          ? "Value must not be between $min and $max bytes"
          : null;
  Validator byteLengthBiggerThan(int min) => (String value) =>
      val.isByteLength(value, min) ? null : "Value must be at least $min bytes";
  Validator byteLengthSmallerThan(int max) =>
      (String value) => val.isByteLength(value, 0, max)
          ? null
          : "Value must be at most $max bytes";
  Validator isCreditCard() => (String value) =>
      val.isCreditCard(value) ? null : "Value must be a credit card number";
  Validator isNotCreditCard() => (String value) =>
      val.isCreditCard(value) ? "Value must not be a credit card number" : null;
  Validator isEmail() => (String value) =>
      val.isEmail(value) ? null : "Value must be an email address";
  Validator isNotEmail() => (String value) =>
      val.isEmail(value) ? "Value must not be an email address" : null;
  Validator isFQDN({bool requireTld = true, bool allowUnderscores = false}) =>
      (String value) => val.isFQDN(value,
              requireTld: requireTld, allowUnderscores: allowUnderscores)
          ? null
          : "Value must be a fully qualified domain name";
  Validator isNotFQDN(
          {bool requireTld = true, bool allowUnderscores = false}) =>
      (String value) => val.isFQDN(value,
              requireTld: requireTld, allowUnderscores: allowUnderscores)
          ? "Value must not be a fully qualified domain name"
          : null;
  Validator containsFullWidth() => (String value) => val.isFullWidth(value)
      ? null
      : "Value must contain full width characters";
  Validator notContainsFullWidth() => (String value) => val.isFullWidth(value)
      ? "Value must not contain full width characters"
      : null;
  Validator containsHalfWidth() => (String value) => val.isHalfWidth(value)
      ? null
      : "Value must contain half width characters";
  Validator notContainsHalfWidth() => (String value) => val.isHalfWidth(value)
      ? "Value must not contain half width characters"
      : null;
  Validator isHex() => (String value) =>
      val.isHexadecimal(value) ? null : "Value must be a hexadecimal string";
  Validator isNotHex() => (String value) => val.isHexadecimal(value)
      ? "Value must not be a hexadecimal string"
      : null;
  Validator is0x() => (String value) =>
      value.startsWith("0x") && val.isHexadecimal(value.replaceFirst("0x", ""))
          ? null
          : "Value must be a 0x hexadecimal string";
  Validator isNot0x() => (String value) =>
      value.startsWith("0x") && val.isHexadecimal(value.replaceFirst("0x", ""))
          ? "Value must not be a 0x hexadecimal string"
          : null;
  Validator isHexColor() => (String value) =>
      val.isHexColor(value) ? null : "Value must be a hexadecimal color";
  Validator isNotHexColor() => (String value) =>
      val.isHexColor(value) ? "Value must not be a hexadecimal color" : null;
  Validator oneOf(List<String> values) => (String value) =>
      val.isIn(value, values) ?? false ? null : "Value must be one of $values";
  Validator notOneOf(List<String> values) =>
      (String value) => val.isIn(value, values) ?? true
          ? "Value must not be one of $values"
          : null;
  Validator isIP([IPVersion? v]) => (String value) =>
      val.isIP(value, v?.version) ? null : "Value must be a valid IP address";
  Validator isNotIP([IPVersion? v]) =>
      (String value) => val.isIP(value, v?.version)
          ? "Value must not be a valid IP address"
          : null;
  Validator isISBN([ISBNVersion? v]) => (String value) =>
      val.isISBN(value, v?.version) ? null : "Value must be a valid ISBN";
  Validator isNotISBN([ISBNVersion? v]) => (String value) =>
      val.isISBN(value, v?.version) ? "Value must not be a valid ISBN" : null;
  Validator isJSON() => (String value) =>
      val.isJSON(value) ? null : "Value must be a valid JSON string";
  Validator isNotJSON() => (String value) =>
      val.isJSON(value) ? "Value must not be a valid JSON string" : null;
  Validator lengthBetween(int min, int max) =>
      (String value) => val.isLength(value, min, max)
          ? null
          : "Value must be between $min and $max characters";
  Validator lengthNotBetween(int min, int max) =>
      (String value) => val.isLength(value, min, max)
          ? "Value must not be between $min and $max characters"
          : null;
  Validator lengthBiggerThan(int min) =>
      (String value) => val.isLength(value, min)
          ? null
          : "Value must be at least $min characters";
  Validator lengthSmallerThan(int max) =>
      (String value) => val.isLength(value, 0, max)
          ? null
          : "Value must be at most $max characters";
  Validator isLowercase() => (String value) =>
      val.isLowercase(value) ? null : "Value must be lowercase";
  Validator isNotLowercase() => (String value) =>
      val.isLowercase(value) ? "Value must not be lowercase" : null;
  Validator isMongoId() => (String value) =>
      val.isMongoId(value) ? null : "Value must be a valid MongoDB ObjectId";
  Validator isNotMongoId() => (String value) => val.isMongoId(value)
      ? "Value must not be a valid MongoDB ObjectId"
      : null;
  Validator containsMultibyte() => (String value) =>
      val.isMultibyte(value) ? null : "Value must contain multibyte characters";
  Validator notContainsMultibyte() => (String value) => val.isMultibyte(value)
      ? "Value must not contain multibyte characters"
      : null;
  Validator isPostalCode(String locale) =>
      (String value) => val.isPostalCode(value, locale)
          ? null
          : "Value must be a valid postal code";
  Validator isNotPostalCode(String locale) =>
      (String value) => val.isPostalCode(value, locale)
          ? "Value must not be a valid postal code"
          : null;
  Validator containsSurrogatePair() => (String value) =>
      val.isSurrogatePair(value) ? null : "Value must contain surrogate pairs";
  Validator notContainsSurrogatePair() =>
      (String value) => val.isSurrogatePair(value)
          ? "Value must not contain surrogate pairs"
          : null;
  Validator isUppercase() =>
      (String value) => value.isEmpty || val.isUppercase(value)
          ? null
          : "Value must be uppercase";
  Validator isNotUppercase() =>
      (String value) => value.isNotEmpty && val.isUppercase(value)
          ? "Value must not be uppercase"
          : null;
  Validator isURL(
          {List<String?> protocols = const ['http', 'https', 'ftp'],
          bool requireTld = true,
          bool requireProtocol = false,
          bool allowUnderscore = false,
          List<String> hostWhitelist = const [],
          List<String> hostBlacklist = const []}) =>
      (String value) => val.isURL(
            value,
            protocols: protocols,
            requireTld: requireTld,
            requireProtocol: requireProtocol,
            allowUnderscore: allowUnderscore,
            hostWhitelist: hostWhitelist,
            hostBlacklist: hostBlacklist,
          )
              ? null
              : "Value must be a valid URL";
  Validator isNotURL(
          {List<String?> protocols = const ['http', 'https', 'ftp'],
          bool requireTld = true,
          bool requireProtocol = false,
          bool allowUnderscore = false,
          List<String> hostWhitelist = const [],
          List<String> hostBlacklist = const []}) =>
      (String value) => val.isURL(
            value,
            protocols: protocols,
            requireTld: requireTld,
            requireProtocol: requireProtocol,
            allowUnderscore: allowUnderscore,
            hostWhitelist: hostWhitelist,
            hostBlacklist: hostBlacklist,
          )
              ? "Value must not be a valid URL"
              : null;
  Validator isUUID([UUIDVersion? v]) => (String value) =>
      val.isUUID(value, v?.version) ? null : "Value must be a valid UUID";

  Validator isNotUUID([UUIDVersion? v]) => (String value) =>
      val.isUUID(value, v?.version) ? "Value must not be a valid UUID" : null;
  Validator matches(String pattern) => (String value) =>
      val.matches(value, pattern) ? null : "Value must match $pattern";
  Validator notMatches(String pattern) => (String value) =>
      val.matches(value, pattern) ? "Value must not match $pattern" : null;
  Validator isEmpty() =>
      (String value) => value.isEmpty ? null : "Value must be empty";
  Validator isNotEmpty() =>
      (String value) => value.isNotEmpty ? null : "Value must not be empty";
}
