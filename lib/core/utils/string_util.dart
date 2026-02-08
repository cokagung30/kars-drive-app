extension StringX on String {
  bool get isEmailPatternValid {
    final pattern = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    return pattern.hasMatch(this);
  }
}
