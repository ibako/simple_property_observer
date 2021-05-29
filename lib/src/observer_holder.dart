import 'property_changed_info.dart';

/// Holds property changes observers.
class ObserverHolder {
  /// The list of observers.
  final _observers = <PropertyChangedCallback>[];

  /// The implement of property changes notification.
  void notify(PropertyChangedInfo info) {
    for (final observer in this._observers) {
      observer.call(info);
    }
  }

  /// The implement of register an observer.
  void register(PropertyChangedCallback observer) {
    _observers.add(observer);
  }

  /// The implement of unregister an observer.
  void unregister(PropertyChangedCallback observer) {
    _observers.remove(observer);
  }
}
