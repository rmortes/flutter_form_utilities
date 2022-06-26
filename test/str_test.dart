import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:form_utilities/validation.dart';
import 'package:form_utilities/validators/str_validator.dart';

void main() {
  group("Str validation", () {
    test("Contains works", () {
      final validator1 = validate([ValStr().contains("hello")]);

      expect(validator1("hello"), null);
      expect(validator1("world"), "Value must contain hello");
      expect(validator1("hello world"), null);
      expect(validator1("hola mundo"), "Value must contain hello");

      final validator2 =
          validate([ValStr().contains("hello"), ValStr().contains("world")]);

      expect(validator2("hello"), "Value must contain world");
      expect(validator2("world"), "Value must contain hello");
      expect(validator2("hello world"), null);
      expect(validator2("hola mundo"), "Value must contain hello");
    });
    test("Not contains works", () {
      final validator1 = validate([ValStr().notContains("hello")]);

      expect(validator1("hello"), "Value must not contain hello");
      expect(validator1("world"), null);
      expect(validator1("hello world"), "Value must not contain hello");
      expect(validator1("hola mundo"), null);

      final validator2 = validate(
          [ValStr().notContains("hello"), ValStr().notContains("world")]);

      expect(validator2("hello"), "Value must not contain hello");
      expect(validator2("world"), "Value must not contain world");
      expect(validator2("hello world"), "Value must not contain hello");
      expect(validator2("hola mundo"), null);
    });
    test("Starts with works", () {
      final validator1 = validate([ValStr().startsWith("hello")]);

      expect(validator1("hello"), null);
      expect(validator1("world"), "Value must start with hello");
      expect(validator1("hello world"), null);
      expect(validator1("hola mundo"), "Value must start with hello");

      final validator2 = validate(
          [ValStr().startsWith("hello"), ValStr().startsWith("world")]);

      expect(validator2("hello"), "Value must start with world");
      expect(validator2("world"), "Value must start with hello");
      expect(validator2("hello world"), "Value must start with world");
      expect(validator2("hola mundo"), "Value must start with hello");
    });
    test("Not starts with works", () {
      final validator1 = validate([ValStr().notStartsWith("hello")]);

      expect(validator1("hello"), "Value must not start with hello");
      expect(validator1("world"), null);
      expect(validator1("hello world"), "Value must not start with hello");
      expect(validator1("hola mundo"), null);

      final validator2 = validate(
          [ValStr().notStartsWith("hello"), ValStr().notStartsWith("world")]);

      expect(validator2("hello"), "Value must not start with hello");
      expect(validator2("world"), "Value must not start with world");
      expect(validator2("hello world"), "Value must not start with hello");
      expect(validator2("hola mundo"), null);
    });
    test("Ends with works", () {
      final validator1 = validate([ValStr().endsWith("hello")]);

      expect(validator1("hello"), null);
      expect(validator1("world"), "Value must end with hello");
      expect(validator1("hello world"), "Value must end with hello");
      expect(validator1("hola mundo"), "Value must end with hello");

      final validator2 =
          validate([ValStr().endsWith("hello"), ValStr().endsWith("world")]);
      expect(validator2("hello"), "Value must end with world");
      expect(validator2("world"), "Value must end with hello");
      expect(validator2("hello world"), "Value must end with hello");
      expect(validator2("hola mundo"), "Value must end with hello");
    });
    test("Eq works", () {
      final validator = validate([ValStr().eq("hello")]);
      expect(validator("hello"), null);
      expect(validator("world"), "Value must be equal to hello");
      expect(validator("hello world"), "Value must be equal to hello");
      expect(validator("hola mundo"), "Value must be equal to hello");
    });
    test("Neq works", () {
      final validator = validate([ValStr().neq("hello")]);
      expect(validator("hello"), "Value must not be equal to hello");
      expect(validator("world"), null);
      expect(validator("hello world"), null);
      expect(validator("hola mundo"), null);
    });
    test("Is alpha works", () {
      final validator = validate([ValStr().isAlpha()]);
      expect(validator("hello"), null);
      expect(validator("WoRlD"), null);
      expect(validator("hello world"),
          "Value must only contain upper and lowercase letters");
      expect(validator("hola mundo"),
          "Value must only contain upper and lowercase letters");
    });
    test("Is not alpha works", () {
      final validator = validate([ValStr().isNotAlpha()]);
      expect(validator("hello"),
          "Value must not only contain upper or lowercase letters");
      expect(validator("WoRlD"),
          "Value must not only contain upper or lowercase letters");
      expect(validator("hello world"), null);
      expect(validator("hola mundo"), null);
    });
    test("Is alphanumeric works", () {
      final validator = validate([ValStr().isAlphanumeric()]);
      expect(validator("hello"), null);
      expect(validator("WoRlD"), null);
      expect(validator("h3110W0r1d"), null);
      expect(validator("h3llo w0rld"),
          "Value must only contain letters and numbers");
      expect(validator("hola mundo"),
          "Value must only contain letters and numbers");
    });
    test("Is not alphanumeric works", () {
      final validator = validate([ValStr().isNotAlphanumeric()]);
      expect(
          validator("hello"), "Value must not only contain letters or numbers");
      expect(
          validator("WoRlD"), "Value must not only contain letters or numbers");
      expect(validator("h3110W0r1d"),
          "Value must not only contain letters or numbers");
      expect(
          validator("23535"), "Value must not only contain letters or numbers");
      expect(validator("hello world"), null);
      expect(validator("h3llo w0rld"), null);
      expect(validator("hola mundo"), null);
    });
    test("Is ascii works", () {
      final validator = validate([ValStr().isAscii()]);
      expect(validator("hello world"), null);
      expect(
          validator("hola£mundo"), "Value must only contain ASCII characters");
    });
    test("Is not ascii works", () {
      final validator = validate([ValStr().isNotAscii()]);
      expect(validator("hello world"),
          "Value must not only contain ASCII characters");
      expect(validator("hola£mundo"), null);
    });
    test("Is base64 works", () {
      final validator = validate([ValStr().isBase64()]);
      expect(validator("hello world"), "Value must be a base64 string");
      expect(validator(base64.encode("hello world".codeUnits)), null);
    });
    test("Is not base64 works", () {
      final validator = validate([ValStr().isNotBase64()]);
      expect(validator("hello world"), null);
      expect(validator(base64.encode("hello world".codeUnits)),
          "Value must not be a base64 string");
    });
    test("Byte length between works", () {
      final validator = validate([ValStr().byteLengthBetween(4, 10)]);
      expect(validator("hello"), null);
      expect(validator("hello world"), "Value must be between 4 and 10 bytes");
      expect(validator("hola mundo"), null);
    });
    test("Byte length not between works", () {
      final validator = validate([ValStr().byteLengthNotBetween(4, 10)]);
      expect(validator("hello"), "Value must not be between 4 and 10 bytes");
      expect(validator("hello world"), null);
      expect(
          validator("hola mundo"), "Value must not be between 4 and 10 bytes");
    });
    test("Byte length bigger than works", () {
      final validator = validate([ValStr().byteLengthBiggerThan(6)]);
      expect(validator("hello"), "Value must be at least 6 bytes");
      expect(validator("hello world"), null);
      expect(validator("hola mundo"), null);
    });
    test("Byte length smaller than works", () {
      final validator = validate([ValStr().byteLengthSmallerThan(6)]);
      expect(validator("hello"), null);
      expect(validator("hello world"), "Value must be at most 6 bytes");
      expect(validator("hola mundo"), "Value must be at most 6 bytes");
    });
    test("Is credit card works", () {
      final validator = validate([ValStr().isCreditCard()]);
      expect(validator("4111111111111111"), null);
      expect(validator("4111111111111"), "Value must be a credit card number");
    });
    test("Is not credit card works", () {
      final validator = validate([ValStr().isNotCreditCard()]);
      expect(validator("4111111111111111"),
          "Value must not be a credit card number");
      expect(validator("4111111111111"), null);
    });
    test("Is email works", () {
      final validator = validate([ValStr().isEmail()]);
      expect(validator("correo@gmail.com"), null);
      expect(validator("correo@gmail"), "Value must be an email address");
    });
    test("Is not email works", () {
      final validator = validate([ValStr().isNotEmail()]);
      expect(
          validator("correo@gmail.com"), "Value must not be an email address");
      expect(validator("correo@gmail"), null);
    });
    test("Is fully qualified domain name works", () {
      final validator = validate([ValStr().isFQDN()]);
      expect(validator("somehost.example.com"), null);
      expect(validator("example.com"), null);
      expect(validator("example.com."),
          "Value must be a fully qualified domain name");
    });
    test("Is not fully qualified domain name works", () {
      final validator = validate([ValStr().isNotFQDN()]);
      expect(validator("somehost.example.com"),
          "Value must not be a fully qualified domain name");
      expect(validator("example.com"),
          "Value must not be a fully qualified domain name");
      expect(validator("example.com."), null);
    });
    test("Contains full width works", () {
      final validator = validate([ValStr().containsFullWidth()]);
      expect(
          validator("hello world"), "Value must contain full width characters");
      expect(validator("hello，world"), null);
    });
    test("Not contains full width works", () {
      final validator = validate([ValStr().notContainsFullWidth()]);
      expect(validator("hello，world"),
          "Value must not contain full width characters");
      expect(validator("hello world"), null);
      expect(validator("hello worldﾀﾞﾀﾞｳﾞｳﾞｳﾞ"), null);
    });
    test("Contains half width works", () {
      final validator = validate([ValStr().containsHalfWidth()]);
      expect(validator("，，，"), "Value must contain half width characters");
      expect(validator("hello world"), null);
      expect(validator("hello，world"), null);
      expect(validator("｢｣"), null);
      expect(validator("｢hello，world｣"), null);
    });
    test("Not contains half width works", () {
      final validator = validate([ValStr().notContainsHalfWidth()]);
      expect(validator("，，，"), null);
      expect(validator("hello world"),
          "Value must not contain half width characters");
      expect(validator("hello，world"),
          "Value must not contain half width characters");
      expect(validator("｢｣"), "Value must not contain half width characters");
      expect(validator("｢hello，world｣"),
          "Value must not contain half width characters");
    });
    test("Is hex works", () {
      final validator = validate([ValStr().isHex()]);
      expect(validator("0xFF"), "Value must be a hexadecimal string");
      expect(validator("0xff"), "Value must be a hexadecimal string");
      expect(validator("FF"), null);
      expect(validator("ff"), null);
      expect(validator("Hello world"), "Value must be a hexadecimal string");
    });
    test("Is not hex works", () {
      final validator = validate([ValStr().isNotHex()]);
      expect(validator("0xFF"), null);
      expect(validator("0xff"), null);
      expect(validator("FF"), "Value must not be a hexadecimal string");
      expect(validator("ff"), "Value must not be a hexadecimal string");
      expect(validator("Hello world"), null);
    });
    test("Is 0x hex works", () {
      final validator = validate([ValStr().is0x()]);
      expect(validator("0xFF"), null);
      expect(validator("0xff"), null);
      expect(validator("FF"), "Value must be a 0x hexadecimal string");
      expect(validator("ff"), "Value must be a 0x hexadecimal string");
      expect(validator("Hello world"), "Value must be a 0x hexadecimal string");
    });
    test("Is not 0x hex works", () {
      final validator = validate([ValStr().isNot0x()]);
      expect(validator("0xFF"), "Value must not be a 0x hexadecimal string");
      expect(validator("0xff"), "Value must not be a 0x hexadecimal string");
      expect(validator("FF"), null);
      expect(validator("ff"), null);
      expect(validator("Hello world"), null);
    });
    test("Is hex color works", () {
      final validator = validate([ValStr().isHexColor()]);
      expect(validator("#JJFFFF"), "Value must be a hexadecimal color");
      expect(validator("#JJFFFF"), "Value must be a hexadecimal color");
      expect(validator("#FFFFFF"), null);
      expect(validator("#ffffff"), null);
      expect(validator("#Hello world"), "Value must be a hexadecimal color");
      expect(validator("Hello world"), "Value must be a hexadecimal color");
    });
    test("Is not hex color works", () {
      final validator = validate([ValStr().isNotHexColor()]);
      expect(validator("#JJFFFF"), null);
      expect(validator("#JJFFFF"), null);
      expect(validator("#FFFFFF"), "Value must not be a hexadecimal color");
      expect(validator("#ffffff"), "Value must not be a hexadecimal color");
      expect(validator("#Hello world"), null);
      expect(validator("Hello world"), null);
    });
    test("One of works", () {
      final validator = validate([
        ValStr().oneOf(["a", "b", "c"])
      ]);
      expect(validator("a"), null);
      expect(validator("b"), null);
      expect(validator("c"), null);
      expect(validator("d"), "Value must be one of [a, b, c]");
    });
    test("Not one of works", () {
      final validator = validate([
        ValStr().notOneOf(["a", "b", "c"])
      ]);
      expect(validator("a"), "Value must not be one of [a, b, c]");
      expect(validator("b"), "Value must not be one of [a, b, c]");
      expect(validator("c"), "Value must not be one of [a, b, c]");
      expect(validator("d"), null);
    });
    test("Is IP", () {
      final validator1 = validate([ValStr().isIP(version: IPVersion.ipV4)]);
      expect(validator1("192.168.0.1"), null);
      expect(validator1("192.168.0.999"), "Value must be a valid IP address");
      expect(validator1("hello world"), "Value must be a valid IP address");
      expect(validator1(""), "Value must be a valid IP address");

      final validator2 = validate([ValStr().isIP(version: IPVersion.ipV6)]);
      expect(validator2("2001:db8:85a3:0:0:8a2e:370:7334"), null);
      expect(validator2("2001:db8:85a3:0:0:8a2e:370:lmao"),
          "Value must be a valid IP address");
      expect(validator2("hello world"), "Value must be a valid IP address");
      expect(validator2(""), "Value must be a valid IP address");

      final validator3 = validate([ValStr().isIP()]);
      expect(validator3("192.168.0.1"), null);
      expect(validator3("192.168.0.999"), "Value must be a valid IP address");
      expect(validator3("2001:db8:85a3:0:0:8a2e:370:7334"), null);
      expect(validator3("2001:db8:85a3:0:0:8a2e:370:lmao"),
          "Value must be a valid IP address");
      expect(validator3("hello world"), "Value must be a valid IP address");
      expect(validator3(""), "Value must be a valid IP address");
    });
    test("Is not IP", () {
      final validator1 = validate([ValStr().isNotIP(version: IPVersion.ipV4)]);
      expect(validator1("192.168.0.1"), "Value must not be a valid IP address");
      expect(validator1("192.168.0.999"), null);
      expect(validator1("hello world"), null);
      expect(validator1(""), null);

      final validator2 = validate([ValStr().isNotIP(version: IPVersion.ipV6)]);
      expect(validator2("2001:db8:85a3:0:0:8a2e:370:7334"),
          "Value must not be a valid IP address");
      expect(validator2("2001:db8:85a3:0:0:8a2e:370:lmao"), null);
      expect(validator2("hello world"), null);
      expect(validator2(""), null);

      final validator3 = validate([ValStr().isNotIP()]);
      expect(validator3("192.168.0.1"), "Value must not be a valid IP address");
      expect(validator3("192.168.0.999"), null);
      expect(validator3("2001:db8:85a3:0:0:8a2e:370:7334"),
          "Value must not be a valid IP address");
      expect(validator3("2001:db8:85a3:0:0:8a2e:370:lmao"), null);
      expect(validator3("hello world"), null);
      expect(validator3(""), null);
    });
    test("Is ISBN works", () {
      final validator1 =
          validate([ValStr().isISBN(version: ISBNVersion.isbnV10)]);
      expect(validator1("1363-276-76-X"), null);
      expect(validator1("1363-276-76-9"), "Value must be a valid ISBN");
      expect(validator1("hello world"), "Value must be a valid ISBN");

      final validator2 =
          validate([ValStr().isISBN(version: ISBNVersion.isbnV13)]);
      expect(validator2("978-06-08-06967-8"), null);
      expect(validator2("978-06-08-06967-9"), "Value must be a valid ISBN");
      expect(validator2("hello world"), "Value must be a valid ISBN");

      final validator3 = validate([ValStr().isISBN()]);
      expect(validator3("1363-276-76-X"), null);
      expect(validator3("1363-276-76-9"), "Value must be a valid ISBN");
      expect(validator3("hello world"), "Value must be a valid ISBN");
      expect(validator3("978-06-08-06967-8"), null);
      expect(validator3("978-06-08-06967-9"), "Value must be a valid ISBN");
      expect(validator3("hello world"), "Value must be a valid ISBN");
    });
    test("Is not ISBN works", () {
      final validator1 =
          validate([ValStr().isNotISBN(version: ISBNVersion.isbnV10)]);
      expect(validator1("1363-276-76-X"), "Value must not be a valid ISBN");
      expect(validator1("1363-276-76-9"), null);
      expect(validator1("hello world"), null);

      final validator2 =
          validate([ValStr().isNotISBN(version: ISBNVersion.isbnV13)]);
      expect(validator2("978-06-08-06967-8"), "Value must not be a valid ISBN");
      expect(validator2("978-06-08-06967-9"), null);
      expect(validator2("hello world"), null);

      final validator3 = validate([ValStr().isNotISBN()]);
      expect(validator3("1363-276-76-X"), "Value must not be a valid ISBN");
      expect(validator3("1363-276-76-9"), null);
      expect(validator3("hello world"), null);
      expect(validator3("978-06-08-06967-8"), "Value must not be a valid ISBN");
      expect(validator3("978-06-08-06967-9"), null);
      expect(validator3("hello world"), null);
    });
    test("Is JSON works", () {
      final validator = validate([ValStr().isJSON()]);
      expect(validator("{}"), null);
      expect(validator("[]"), null);
      expect(validator("{\"a\":1}"), null);
      expect(validator("[1,2,3]"), null);
      expect(validator('"hello world"'), null);
      expect(validator("{\"a\":1,}"), "Value must be a valid JSON string");
      expect(validator("hello world"), "Value must be a valid JSON string");
      expect(validator(""), "Value must be a valid JSON string");
    });
    test("Is not JSON works", () {
      final validator = validate([ValStr().isNotJSON()]);
      expect(validator("{}"), "Value must not be a valid JSON string");
      expect(validator("[]"), "Value must not be a valid JSON string");
      expect(validator("{\"a\":1}"), "Value must not be a valid JSON string");
      expect(validator("[1,2,3]"), "Value must not be a valid JSON string");
      expect(
          validator('"hello world"'), "Value must not be a valid JSON string");
      expect(validator("{\"a\":1,}"), null);
      expect(validator("hello world"), null);
      expect(validator(""), null);
    });
    test("Length between works", () {
      final validator = validate([ValStr().lengthBetween(6, 12)]);
      expect(validator("hello"), "Value must be between 6 and 12 characters");
      expect(validator("hello world"), null);
    });
    test("Length not between works", () {
      final validator = validate([ValStr().lengthNotBetween(6, 12)]);
      expect(validator("hello"), null);
      expect(validator("hello world"),
          "Value must not be between 6 and 12 characters");
    });
    test("Length bigger than works", () {
      final validator = validate([ValStr().lengthBiggerThan(6)]);
      expect(validator("hello"), "Value must be at least 6 characters");
      expect(validator("hello world"), null);
    });
    test("Length smaller than works", () {
      final validator = validate([ValStr().lengthSmallerThan(6)]);
      expect(validator("hello"), null);
      expect(validator("hello world"), "Value must be at most 6 characters");
    });
    test("Is lowercase works", () {
      final validator = validate([ValStr().isLowercase()]);
      expect(validator("hello"), null);
      expect(validator("HELLO"), "Value must be lowercase");
    });
    test("Is not lowercase works", () {
      final validator = validate([ValStr().isNotLowercase()]);
      expect(validator("hello"), "Value must not be lowercase");
      expect(validator("HELLO"), null);
    });
    test("Is mongo ID works", () {
      final validator = validate([ValStr().isMongoId()]);
      expect(validator("507f1f77bcf86cd799439011"), null);
      expect(validator("507f1f77bcf86cd79943901"),
          "Value must be a valid MongoDB ObjectId");
      expect(
          validator("hello world"), "Value must be a valid MongoDB ObjectId");
      expect(validator(""), "Value must be a valid MongoDB ObjectId");
    });
    test("Is not mongo ID works", () {
      final validator = validate([ValStr().isNotMongoId()]);
      expect(validator("507f1f77bcf86cd799439011"),
          "Value must not be a valid MongoDB ObjectId");
      expect(validator("507f1f77bcf86cd79943901"), null);
      expect(validator("hello world"), null);
      expect(validator(""), null);
    });
    test("Contains multibyte works", () {
      final validator = validate([ValStr().containsMultibyte()]);
      expect(validator("こんにちは"), null);
      expect(validator("hello"), "Value must contain multibyte characters");
      expect(
          validator("hello world"), "Value must contain multibyte characters");
      expect(validator(""), "Value must contain multibyte characters");
    });
    test("Not contains multibyte works", () {
      final validator = validate([ValStr().notContainsMultibyte()]);
      expect(validator("こんにちは"), "Value must not contain multibyte characters");
      expect(validator("hello"), null);
      expect(validator("hello world"), null);
      expect(validator(""), null);
    });
    test("Is postal code works", () {
      final validator = validate([ValStr().isPostalCode("ES")]);
      expect(validator("12345"), null);
      expect(validator("123456"), "Value must be a valid postal code");
      expect(validator("hello world"), "Value must be a valid postal code");
      expect(validator(""), "Value must be a valid postal code");
    });
    test("Is not postal code works", () {
      final validator = validate([ValStr().isNotPostalCode("ES")]);
      expect(validator("12345"), "Value must not be a valid postal code");
      expect(validator("123456"), null);
      expect(validator("hello world"), null);
      expect(validator(""), null);
    });
    test("Contains surrogate pair works", () {
      final validator = validate([ValStr().containsSurrogatePair()]);
      expect(validator("💩"), null);
      expect(validator("hello world"), "Value must contain surrogate pairs");
      expect(validator(""), "Value must contain surrogate pairs");
    });
    test("Not contains surrogate pair works", () {
      final validator = validate([ValStr().notContainsSurrogatePair()]);
      expect(validator("💩"), "Value must not contain surrogate pairs");
      expect(validator("hello world"), null);
      expect(validator(""), null);
    });
    test("Is uppercase works", () {
      final validator = validate([ValStr().isUppercase()]);
      expect(validator("HELLO"), null);
      expect(validator("HELLO WORLD"), null);
      expect(validator("hello"), "Value must be uppercase");
      expect(validator(""), null);
    });
    test("Is not uppercase works", () {
      final validator = validate([ValStr().isNotUppercase()]);
      expect(validator("HELLO"), "Value must not be uppercase");
      expect(validator("HELLO WORLD"), "Value must not be uppercase");
      expect(validator("hello"), null);
      expect(validator(""), null);
    });
    test("Is URL works", () {
      final validator1 = validate([ValStr().isURL()]);
      expect(validator1("http://www.google.com"), null);
      expect(validator1("http://www.google.com/"), null);
      expect(validator1("https://www.google.com"), null);
      expect(validator1("ftp://www.google.com"), null);
      expect(validator1("file://www.google.com"), "Value must be a valid URL");

      final validatorAllowFile = validate([
        ValStr().isURL(protocols: ["file"])
      ]);
      expect(validatorAllowFile("file://www.google.com"), null);
      expect(validatorAllowFile("http://www.google.com"),
          "Value must be a valid URL");

      final validatorWhitelist = validate([
        ValStr().isURL(hostWhitelist: ["example.com"])
      ]);
      expect(validatorWhitelist("http://www.google.com"),
          "Value must be a valid URL");
      expect(validatorWhitelist("http://example.com"), null);
    });
    test("Is not URL works", () {
      final validator = validate([ValStr().isNotURL()]);
      expect(
          validator("http://www.google.com"), "Value must not be a valid URL");
      expect(
          validator("http://www.google.com/"), "Value must not be a valid URL");
      expect(
          validator("https://www.google.com"), "Value must not be a valid URL");
      expect(
          validator("ftp://www.google.com"), "Value must not be a valid URL");
      expect(validator("file://www.google.com"), null);
      expect(validator("hello world"), null);
    });
    test("Is UUID works", () {
      final validatorUUID3 =
          validate([ValStr().isUUID(version: UUIDVersion.uuid3)]);
      expect(validatorUUID3("a0473a67-27a1-3c05-a2d1-5c134639347f"), null);
      expect(validatorUUID3("a0473a6727a13c05a2d15c134639347f"),
          "Value must be a valid UUID");
      expect(validatorUUID3("a0473a67-27a1-3c05-a2d1-5c134639347z"),
          "Value must be a valid UUID");
      expect(validatorUUID3("hello world"), "Value must be a valid UUID");

      final validatorUUID4 =
          validate([ValStr().isUUID(version: UUIDVersion.uuid4)]);
      expect(validatorUUID4("465494e7-f787-4fe3-89e5-75ed359ccd32"), null);
      expect(validatorUUID4("465494e7f7874fe389e575ed359ccd32"),
          "Value must be a valid UUID");
      expect(validatorUUID4("465494e7-f787-4fe3-89e5-75ed359ccd3z"),
          "Value must be a valid UUID");
      expect(validatorUUID4("hello world"), "Value must be a valid UUID");

      final validatorUUID5 =
          validate([ValStr().isUUID(version: UUIDVersion.uuid5)]);
      expect(validatorUUID5("cfbff0d1-9375-5685-968c-48ce8b15ae17"), null);
      expect(validatorUUID5("cfbff0d193755685968c48ce8b15ae17"),
          "Value must be a valid UUID");
      expect(validatorUUID5("cfbff0d1-9375-5685-968c-48ce8b15ae1z"),
          "Value must be a valid UUID");
      expect(validatorUUID5("hello world"), "Value must be a valid UUID");

      final validatorUUID = validate([ValStr().isUUID()]);
      expect(validatorUUID("cfbff0d1-9375-5685-968c-48ce8b15ae17"), null);
      expect(validatorUUID("cfbff0d193755685968c48ce8b15ae17"),
          "Value must be a valid UUID");
      expect(validatorUUID("cfbff0d1-9375-5685-968c-48ce8b15ae1z"),
          "Value must be a valid UUID");
      expect(validatorUUID("hello world"), "Value must be a valid UUID");
    });
    test("Is not UUID works", () {
      final validator = validate([ValStr().isNotUUID()]);
      expect(validator("a0473a67-27a1-3c05-a2d1-5c134639347f"),
          "Value must not be a valid UUID");
      expect(validator("a0473a6727a13c05a2d15c134639347f"), null);
      expect(validator("a0473a67-27a1-3c05-a2d1-5c134639347z"), null);
      expect(validator("hello world"), null);
    });
    test("Matches works", () {
      final validator = validate([ValStr().matches(r"^[a-z0-9]+$")]);
      expect(validator("helloworld"), null);
      expect(validator("H3ll0"), r"Value must match ^[a-z0-9]+$");
      expect(validator("hello world"), r"Value must match ^[a-z0-9]+$");
      expect(validator(""), r"Value must match ^[a-z0-9]+$");
    });
    test("Is not matches works", () {
      final validator = validate([ValStr().notMatches(r"^[a-z0-9]+$")]);
      expect(validator("helloworld"), r"Value must not match ^[a-z0-9]+$");
      expect(validator("H3ll0"), null);
      expect(validator("hello world"), null);
      expect(validator(""), null);
    });
  });
}
