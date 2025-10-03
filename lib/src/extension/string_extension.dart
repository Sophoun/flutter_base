extension StringExtension on String? {
  /// Return null or value but not empty
  String? get orNull {
    if (this == null || this!.isEmpty) return null;
    return this;
  }

  /// Return empty or value but not null
  String get orEmpty => this ?? '';
}
