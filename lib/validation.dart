typedef Validator = String? Function(String value);

Validator validate(List<Validator> validators, {String? error}) {
  return (String value) {
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
Validator or(List<Validator> validators, {String? error}) {
  return (String value) {
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
Validator and(List<Validator> validators, {String? error}) {
  return validate(validators, error: error);
}
