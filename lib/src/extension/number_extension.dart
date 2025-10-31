extension NumberExtension on num? {
  /// Format number with commas as thousand separators
  String _formatWithCommas(num number, {int decimalPlaces = 2}) {
    final parts = number.toStringAsFixed(decimalPlaces).split('.');
    final integerPart = parts[0];
    final fractionalPart = parts.length > 1 ? '.${parts[1]}' : '';

    final reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final formattedIntegerPart = integerPart.replaceAllMapped(
      reg,
      (Match match) => '${match[1]},',
    );

    return formattedIntegerPart + fractionalPart;
  }

  /// Check if number is null or zero
  bool get isNullOrZero => this == null || this == 0;

  /// Check if number is not null and not zero
  bool get isNotNullOrZero => this != null && this != 0;

  /// Check if number is null or negative
  bool get isNullOrNegative => this == null || this! < 0;

  /// Check if number is not null and not negative
  bool get isNotNullOrNegative => this != null && this! >= 0;

  /// Format number to string with fixed decimal places
  String toStringAsFixedSafe(int fractionDigits) {
    if (this == null) return '0';
    return this!.toStringAsFixed(fractionDigits);
  }

  /// Format number to currency string
  String formatAmount(int fractionDigits) {
    if (this == null) return '0.00';
    // final formater =
    return _formatWithCommas(this!, decimalPlaces: fractionDigits);
  }

  /// Format number to currency string with dollar sign
  String formatCurrencySuffix({int fractionDigits = 2, String symbol = '\$'}) {
    if (this == null) return '0.00 $symbol';
    return '${_formatWithCommas(this!, decimalPlaces: fractionDigits)} $symbol';
  }

  /// Format number to currency string with dollar sign prefix
  String formatCurrencyPrefix({int fractionDigits = 2, String symbol = '\$'}) {
    if (this == null) return '$symbol 0.00';
    return '$symbol ${_formatWithCommas(this!, decimalPlaces: fractionDigits)}';
  }

  /// Convert number to DateTime
  DateTime? toDateTime() {
    if (this == null) return null;
    try {
      return DateTime.fromMillisecondsSinceEpoch(this!.toInt());
    } catch (e) {
      return null;
    }
  }

  /// To unix timestamp second
  num toUnixTimestampSecond() {
    if (this == null) return 0;
    return this! * 1000;
  }
}
