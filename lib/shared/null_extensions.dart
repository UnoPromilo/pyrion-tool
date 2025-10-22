extension DobleNullExtension on double? {
  double? operator +(double other) {
    if (this == null) {
      return null;
    }
    return this! + other;
  }
}
