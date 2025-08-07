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

  // Method to register a dependency lazily
  void registerLazy<T>(T Function(DiContainer container) factory) {
    _dependencies[T] = factory(_instance) as Object;
  }

  // Method to get a dependency
  T get<T>() {
    if (!_dependencies.containsKey(T)) {
      throw Exception('Instance not found: $T');
    }
    return _dependencies[T] as T;
  }
}
