import 'package:flutter/widgets.dart';
import 'package:flutter_base/src/base/base_vm.dart';

/// The view model wrapper
class VmInherited extends InheritedWidget {
  const VmInherited({
    super.key,
    required super.child,
    required this.viewModels,
  });

  /// Collection of registered viewmodels
  final List<BaseVm> viewModels;

  // Get a view model by their type
  static T of<T>(BuildContext context) {
    try {
      final inherited = context
          .dependOnInheritedWidgetOfExactType<VmInherited>()!;
      return inherited.viewModels.firstWhere((e) => e is T) as T;
    } catch (e) {
      throw Exception("ViewModel: ${T.runtimeType} not found");
    }
  }

  @override
  bool updateShouldNotify(covariant VmInherited oldWidget) {
    return oldWidget != this;
  }
}
