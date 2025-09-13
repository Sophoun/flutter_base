class EventBus {
  EventBus._();

  static final _subscriberIds = List<MapEntry<int, Function(int, dynamic)>>.of(
    [],
  );

  /// Register an event id
  static void register(
    List<int> ids,
    void Function(int id, dynamic data) onEvent,
  ) {
    for (var id in ids) {
      _subscriberIds.add(MapEntry(id, onEvent));
    }
  }

  /// Remove event id
  static void unregister(List<int> ids) {
    for (var id in ids) {
      _subscriberIds.removeWhere((e) => e.key == id);
    }
  }

  /// Fire an event with data
  static void fire(int id, {dynamic data}) {
    _subscriberIds.where((e) => e.key == id).forEach((e) {
      e.value.call(e.key, data);
    });
  }
}
