/// DI Container
class DiContainer {
  final _dependencies = <Type, Object>{};

  // Singleton instance
  static final DiContainer _instance = DiContainer._internal();

  factory DiContainer() {
    return _instance;
  }

  DiContainer._internal();

  // Method to register a dependency
  void register<T>(T dependency) {
    _dependencies[T] = dependency!;
  }

  // Method to get a dependency
  T get<T>() {
    if (!_dependencies.containsKey(T)) {
      throw Exception('Dependency not found: $T');
    }
    return _dependencies[T] as T;
  }
}
