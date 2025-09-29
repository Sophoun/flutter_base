import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  Pref._(this._preferences);

  SharedPreferences? _preferences;

  static Pref? _pref;

  /// Initialize shared preferences
  static Future<void> init() async {
    _pref ??= Pref._(await SharedPreferences.getInstance());
    _pref!;
  }

  /// Expose the instance
  factory Pref.instance() => _pref!;

  /// Get Share preferences
  SharedPreferences get p => _preferences!;

  /// Run the preferences body
  void apply(Function(SharedPreferences pref) callback) {
    callback(_preferences!);
  }
}
