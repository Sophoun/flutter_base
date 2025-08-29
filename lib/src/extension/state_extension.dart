import 'dart:async';
export 'screen_extension.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:flutter_base/src/localization/localize_inherited.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Vallue notifier builder function
extension ValueNotifierAsWidgetBuilder<T> on ValueNotifier<T?> {
  /// Converts the ValueNotifier to a Widget that rebuilds when the value changes.
  Widget builder({required Widget Function(T? value) build, Key? key}) {
    return ValueListenableBuilder<T?>(
      valueListenable: this,
      builder: (context, value, child) {
        return build(value);
      },
      key: key,
    );
  }
}

/// Is loading
final isAppLoading = ValueNotifier(false);

/// Post loading value
extension PostLoadingExtension on ChangeNotifier {
  /// Post loading value
  void postLoading(bool loading) {
    isAppLoading.value = loading;
  }
}

///
/// Get di/vm extensions
///
extension StatelessExtension on StatelessWidget {
  T inject<T>() => ServiceLocator().get<T>();
}

extension StatefulExtension on StatefulWidget {
  T inject<T>() => ServiceLocator().get<T>();
}

extension StateExtension on State {
  T inject<T>() => ServiceLocator().get<T>();
}

extension ChangeNotifierExtension on ChangeNotifier {
  T inject<T>() => ServiceLocator().get<T>();
}

/// Language extension
extension LanguageExtension on BuildContext {
  LocalizeInherited get local => LocalizeInherited.of(this);
  T t<T>() => local.register.l as T;
}

/// Message dialog
final messageDialog =
    StreamController<MapEntry<bool, MessageDialogData>>.broadcast();

/// Message dialog data that hold all data needed by dialog
class MessageDialogData {
  final String? title;
  final String? message;
  final MessageDialogType type;
  final String okText;
  final String cancelText;
  final Function()? onOk;
  final Function()? onCancel;

  const MessageDialogData({
    this.title,
    this.message,
    this.type = MessageDialogType.okCanncel,
    this.onOk,
    this.onCancel,
    this.okText = "Ok",
    this.cancelText = "Cancel",
  });
}

/// Message dialog type, to distingue between dialog style
enum MessageDialogType { ok, okCanncel, toast }

/// Show message dialog
void showMessage({
  String? title,
  required String message,
  Function()? onOk,
  Function()? onCancel,
  MessageDialogType type = MessageDialogType.ok,
  String okText = "Ok",
  String cancelText = "Cancel",
}) {
  messageDialog.sink.add(
    MapEntry(
      true,
      MessageDialogData(
        title: title,
        message: message,
        onOk: onOk,
        onCancel: onCancel,
        type: type,
        okText: okText,
        cancelText: cancelText,
      ),
    ),
  );
}

/// Show message toast
void showToast(String message) {
  showMessage(message: message, type: MessageDialogType.toast);
}

/// Hide message dialog
void hideMessage() {
  messageDialog.sink.add(MapEntry(false, MessageDialogData()));
}

/// Provide the preferencessor
SharedPreferences get p => Pref.instance().p;
