typedef Validator = String? Function(String value);
typedef ValidatorFunction = String? Function(String? value);

ValidatorFunction validate(List<Validator> validators,
    {String? error}) {
  return (String? value) {
    if (value == null) return null;
    for (var validator in validators) {
      final result = validator(value);
      if (result != null) {
        return error ?? result;
      }
    }
    return null;
  };
}

/// This helper joins some validators together so that only one of them needs to be satisfied.
ValidatorFunction or(List<Validator> validators, {String? error}) {
  return (String? value) {
    if (value == null) return null;
    final errors = <String>[];
    for (var validator in validators) {
      final result = validator(value);
      if (result == null) {
        return null;
      } else {
        errors.add(result);
      }
    }
    return error ?? errors.join(", ");
  };
}

/// This helper joins some validators together so that all of them need to be satisfied.
ValidatorFunction and(List<Validator> validators, {String? error}) {
  return validate(validators, error: error);
}
