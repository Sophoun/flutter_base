import 'package:flutter/widgets.dart';

/// DI Container
class VmContainer {
  final _dependencies = <Type, ChangeNotifier>{};

  // Singleton instance
  static final VmContainer _instance = VmContainer._internal();

  factory VmContainer() {
    return _instance;
  }

  VmContainer._internal();

  // Method to register a dependency
  void register<T extends ChangeNotifier>(T dependency) {
    _dependencies[T] = dependency;
  }

  // Method to register a dependency lazily
  void registerLazy<T extends ChangeNotifier>(
    T Function(VmContainer container) factory,
  ) {
    _dependencies[T] = factory(_instance) as ChangeNotifier;
  }

  // Method to get a dependency
  T get<T>() {
    if (!_dependencies.containsKey(T)) {
      throw Exception('VM Dependency not found: $T');
    }
    return _dependencies[T] as T;
  }
}
