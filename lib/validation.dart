typedef Validator = String? Function(String value);

String? Function(String) validate(List<Validator> validators) {
  return (String value) {
    for (var validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  };
}
