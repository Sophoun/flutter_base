class VmContainer {
  // Private constructor
  VmContainer._internal();
  final _viewModels = <Type, Object>{};

  // Singleton instance
  static final VmContainer _instance = VmContainer._internal();

  factory VmContainer() {
    return _instance;
  }

  // Method to register a dependency
  void register<T>(T viewModel) {
    _viewModels[viewModel.runtimeType] = viewModel!;
  }

  // Method to register a dependency lazily
  void registerLazy<T>(T Function(VmContainer container) factory) {
    _viewModels[T] = factory(_instance) as Object;
  }

  // Method to get a dependency
  T get<T>() {
    if (!_viewModels.containsKey(T)) {
      throw Exception('View Model not found: $T');
    }
    return _viewModels[T] as T;
  }
}
