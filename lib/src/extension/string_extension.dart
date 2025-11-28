extension StringExtension on String? {
  /// Return null or value but not empty
  String? get orNull {
    if (this == null || this!.isEmpty) return null;
    return this;
  }

  /// Return empty or value but not null
  String get orEmpty => this ?? '';

  /// Check value is null or empty
  bool get isNullOrEmpty {
    if (this == null) return true;
    if (this!.isEmpty) return true;
    return false;
  }

  /// Check value is not empty
  bool get isNotEmpty {
    return this != null && this!.length > 1;
  }
}
