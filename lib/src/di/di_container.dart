/// This class hold all the module that want to inject to widget,
/// view model or other that provide
class DiContainer {
  DiContainer({List<MapEntry<Type, dynamic>> initModules = const []}) {
    _modules.clear();
    _modules.addAll(initModules);
  }

  static final List<MapEntry<Type, dynamic>> _modules = [];

  /// Get instance from di
  static T get<T>() {
    return _modules.firstWhere((element) => element.key == T).value;
  }
}
