import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  Pref._() {
    SharedPreferences.getInstance()
        .then((value) {
          _preferences = value;
        })
        .catchError((e) {
          log(e.toString());
        });
  }

  SharedPreferences? _preferences;

  static Pref? _pref;

  /// Initialize shared preferences
  factory Pref.init() {
    _pref ??= Pref._();
    return _pref!;
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
