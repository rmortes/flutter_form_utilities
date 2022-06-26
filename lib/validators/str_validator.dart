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
  Validator contains(String contains, {String? error}) =>
      (str) => val.contains(str, contains)
          ? null
          : error ?? "Value must contain $contains";

  Validator notContains(String notContains, {String? error}) =>
      (str) => val.contains(str, notContains)
          ? error ?? "Value must not contain $notContains"
          : null;

  Validator startsWith(String startsWith, {String? error}) =>
      (str) => str.startsWith(startsWith)
          ? null
          : error ?? "Value must start with $startsWith";

  Validator notStartsWith(String notStartsWith, {String? error}) =>
      (str) => str.startsWith(notStartsWith)
          ? error ?? "Value must not start with $notStartsWith"
          : null;

  Validator endsWith(String endsWith, {String? error}) => (str) =>
      str.endsWith(endsWith) ? null : error ?? "Value must end with $endsWith";

  Validator notEndsWith(String notEndsWith, {String? error}) =>
      (str) => str.endsWith(notEndsWith)
          ? error ?? "Value must not end with $notEndsWith"
          : null;

  Validator eq(String eq, {String? error}) => (str) =>
      val.equals(str, eq) ? null : error ?? "Value must be equal to $eq";

  Validator neq(String neq, {String? error}) => (str) =>
      val.equals(str, neq) ? error ?? "Value must not be equal to $neq" : null;

  Validator isAlpha({String? error}) => (str) => val.isAlpha(str)
      ? null
      : error ?? "Value must only contain upper and lowercase letters";

  Validator isNotAlpha({String? error}) => (str) => val.isAlpha(str)
      ? error ?? "Value must not only contain upper or lowercase letters"
      : null;

  Validator isAlphanumeric({String? error}) => (str) => val.isAlphanumeric(str)
      ? null
      : error ?? "Value must only contain letters and numbers";

  Validator isNotAlphanumeric({String? error}) =>
      (str) => val.isAlphanumeric(str)
          ? error ?? "Value must not only contain letters or numbers"
          : null;

  Validator isAscii({String? error}) => (str) => val.isAscii(str)
      ? null
      : error ?? "Value must only contain ASCII characters";

  Validator isNotAscii({String? error}) => (str) => val.isAscii(str)
      ? error ?? "Value must not only contain ASCII characters"
      : null;

  Validator isBase64({String? error}) => (str) =>
      val.isBase64(str) ? null : error ?? "Value must be a base64 string";

  Validator isNotBase64({String? error}) => (str) =>
      val.isBase64(str) ? error ?? "Value must not be a base64 string" : null;

  Validator byteLengthBetween(int min, int max, {String? error}) =>
      (str) => val.isByteLength(str, min, max)
          ? null
          : error ?? "Value must be between $min and $max bytes";

  Validator byteLengthNotBetween(int min, int max, {String? error}) =>
      (str) => val.isByteLength(str, min, max)
          ? error ?? "Value must not be between $min and $max bytes"
          : null;

  Validator byteLengthBiggerThan(int min, {String? error}) =>
      (str) => val.isByteLength(str, min)
          ? null
          : error ?? "Value must be at least $min bytes";

  Validator byteLengthSmallerThan(int max, {String? error}) =>
      (str) => val.isByteLength(str, 0, max)
          ? null
          : error ?? "Value must be at most $max bytes";

  Validator isCreditCard({String? error}) => (str) => val.isCreditCard(str)
      ? null
      : error ?? "Value must be a credit card number";

  Validator isNotCreditCard({String? error}) => (str) => val.isCreditCard(str)
      ? error ?? "Value must not be a credit card number"
      : null;

  Validator isEmail({String? error}) => (str) =>
      val.isEmail(str) ? null : error ?? "Value must be an email address";

  Validator isNotEmail({String? error}) => (str) =>
      val.isEmail(str) ? error ?? "Value must not be an email address" : null;

  Validator isFQDN(
          {bool requireTld = true,
          bool allowUnderscores = false,
          String? error}) =>
      (str) => val.isFQDN(str,
              requireTld: requireTld, allowUnderscores: allowUnderscores)
          ? null
          : error ?? "Value must be a fully qualified domain name";

  Validator isNotFQDN(
          {bool requireTld = true,
          bool allowUnderscores = false,
          String? error}) =>
      (str) => val.isFQDN(str,
              requireTld: requireTld, allowUnderscores: allowUnderscores)
          ? error ?? "Value must not be a fully qualified domain name"
          : null;

  Validator containsFullWidth({String? error}) => (str) => val.isFullWidth(str)
      ? null
      : error ?? "Value must contain full width characters";

  Validator notContainsFullWidth({String? error}) =>
      (str) => val.isFullWidth(str)
          ? error ?? "Value must not contain full width characters"
          : null;

  Validator containsHalfWidth({String? error}) => (str) => val.isHalfWidth(str)
      ? null
      : error ?? "Value must contain half width characters";

  Validator notContainsHalfWidth({String? error}) =>
      (str) => val.isHalfWidth(str)
          ? error ?? "Value must not contain half width characters"
          : null;

  Validator isHex({String? error}) => (String str) => val.isHexadecimal(str)
      ? null
      : error ?? "Value must be a hexadecimal string";

  Validator isNotHex({String? error}) => (str) => val.isHexadecimal(str)
      ? error ?? "Value must not be a hexadecimal string"
      : null;

  Validator is0x({String? error}) => (str) =>
      str.startsWith("0x") && val.isHexadecimal(str.replaceFirst("0x", ""))
          ? null
          : error ?? "Value must be a 0x hexadecimal string";

  Validator isNot0x({String? error}) => (String str) =>
      str.startsWith("0x") && val.isHexadecimal(str.replaceFirst("0x", ""))
          ? error ?? "Value must not be a 0x hexadecimal string"
          : null;

  Validator isHexColor({String? error}) => (str) =>
      val.isHexColor(str) ? null : error ?? "Value must be a hexadecimal color";

  Validator isNotHexColor({String? error}) => (str) => val.isHexColor(str)
      ? error ?? "Value must not be a hexadecimal color"
      : null;

  Validator oneOf(List<String> values, {String? error}) =>
      (str) => val.isIn(str, values) ?? false
          ? null
          : error ?? "Value must be one of $values";

  Validator notOneOf(List<String> values, {String? error}) =>
      (str) => val.isIn(str, values) ?? true
          ? error ?? "Value must not be one of $values"
          : null;

  Validator isIP({IPVersion? version, String? error}) =>
      (str) => val.isIP(str, version?.version)
          ? null
          : error ?? "Value must be a valid IP address";

  Validator isNotIP({IPVersion? version, String? error}) =>
      (str) => val.isIP(str, version?.version)
          ? error ?? "Value must not be a valid IP address"
          : null;

  Validator isISBN({ISBNVersion? version, String? error}) =>
      (str) => val.isISBN(str, version?.version)
          ? null
          : error ?? "Value must be a valid ISBN";

  Validator isNotISBN({ISBNVersion? version, String? error}) =>
      (str) => val.isISBN(str, version?.version)
          ? error ?? "Value must not be a valid ISBN"
          : null;

  Validator isJSON({String? error}) => (str) =>
      val.isJSON(str) ? null : error ?? "Value must be a valid JSON string";

  Validator isNotJSON({String? error}) => (str) =>
      val.isJSON(str) ? error ?? "Value must not be a valid JSON string" : null;

  Validator lengthBetween(int min, int max, {String? error}) =>
      (str) => val.isLength(str, min, max)
          ? null
          : error ?? "Value must be between $min and $max characters";

  Validator lengthNotBetween(int min, int max, {String? error}) =>
      (str) => val.isLength(str, min, max)
          ? error ?? "Value must not be between $min and $max characters"
          : null;

  Validator lengthBiggerThan(int min, {String? error}) =>
      (str) => val.isLength(str, min)
          ? null
          : error ?? "Value must be at least $min characters";

  Validator lengthSmallerThan(int max, {String? error}) =>
      (str) => val.isLength(str, 0, max)
          ? null
          : error ?? "Value must be at most $max characters";

  Validator isLowercase({String? error}) =>
      (str) => val.isLowercase(str) ? null : error ?? "Value must be lowercase";

  Validator isNotLowercase({String? error}) => (str) =>
      val.isLowercase(str) ? error ?? "Value must not be lowercase" : null;

  Validator isMongoId({String? error}) => (str) => val.isMongoId(str)
      ? null
      : error ?? "Value must be a valid MongoDB ObjectId";

  Validator isNotMongoId({String? error}) => (str) => val.isMongoId(str)
      ? error ?? "Value must not be a valid MongoDB ObjectId"
      : null;

  Validator containsMultibyte({String? error}) => (str) => val.isMultibyte(str)
      ? null
      : error ?? "Value must contain multibyte characters";

  Validator notContainsMultibyte({String? error}) =>
      (str) => val.isMultibyte(str)
          ? error ?? "Value must not contain multibyte characters"
          : null;

  Validator isPostalCode(String locale, {String? error}) =>
      (str) => val.isPostalCode(str, locale)
          ? null
          : error ?? "Value must be a valid postal code";

  Validator isNotPostalCode(String locale, {String? error}) =>
      (str) => val.isPostalCode(str, locale)
          ? error ?? "Value must not be a valid postal code"
          : null;

  Validator containsSurrogatePair({String? error}) =>
      (str) => val.isSurrogatePair(str)
          ? null
          : error ?? "Value must contain surrogate pairs";

  Validator notContainsSurrogatePair({String? error}) =>
      (str) => val.isSurrogatePair(str)
          ? error ?? "Value must not contain surrogate pairs"
          : null;
  Validator isUppercase({String? error}) =>
      (str) => str.isEmpty || val.isUppercase(str)
          ? null
          : error ?? "Value must be uppercase";

  Validator isNotUppercase({String? error}) =>
      (str) => str.isNotEmpty && val.isUppercase(str)
          ? error ?? "Value must not be uppercase"
          : null;

  Validator isURL(
          {List<String?> protocols = const ['http', 'https', 'ftp'],
          bool requireTld = true,
          bool requireProtocol = false,
          bool allowUnderscore = false,
          List<String> hostWhitelist = const [],
          List<String> hostBlacklist = const [],
          String? error}) =>
      (str) => val.isURL(
            str,
            protocols: protocols,
            requireTld: requireTld,
            requireProtocol: requireProtocol,
            allowUnderscore: allowUnderscore,
            hostWhitelist: hostWhitelist,
            hostBlacklist: hostBlacklist,
          )
              ? null
              : error ?? "Value must be a valid URL";

  Validator isNotURL(
          {List<String?> protocols = const ['http', 'https', 'ftp'],
          bool requireTld = true,
          bool requireProtocol = false,
          bool allowUnderscore = false,
          List<String> hostWhitelist = const [],
          List<String> hostBlacklist = const [],
          String? error}) =>
      (str) => val.isURL(
            str,
            protocols: protocols,
            requireTld: requireTld,
            requireProtocol: requireProtocol,
            allowUnderscore: allowUnderscore,
            hostWhitelist: hostWhitelist,
            hostBlacklist: hostBlacklist,
          )
              ? error ?? "Value must not be a valid URL"
              : null;

  Validator isUUID({UUIDVersion? version, String? error}) =>
      (str) => val.isUUID(str, version?.version)
          ? null
          : error ?? "Value must be a valid UUID";

  Validator isNotUUID({UUIDVersion? version, String? error}) =>
      (str) => val.isUUID(str, version?.version)
          ? error ?? "Value must not be a valid UUID"
          : null;

  Validator matches(String pattern, {String? error}) => (str) =>
      val.matches(str, pattern) ? null : error ?? "Value must match $pattern";

  Validator notMatches(String pattern, {String? error}) =>
      (str) => val.matches(str, pattern)
          ? error ?? "Value must not match $pattern"
          : null;

  Validator isEmpty({String? error}) =>
      (str) => str.isEmpty ? null : error ?? "Value must be empty";

  Validator isNotEmpty({String? error}) =>
      (str) => str.isNotEmpty ? null : error ?? "Value must not be empty";
}
