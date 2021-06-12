import 'property_changed_info.dart';

mixin PropertyObservable {
  /// The list of observers.
  final _observers = <PropertyChangedCallback>[];

  /// Register a property changes observer.
  void registerObserver(PropertyChangedCallback observer) {
    _observers.add(observer);
  }

  /// Unregister a property changes observer.
  void unregisterObserver(PropertyChangedCallback observer) {
    _observers.remove(observer);
  }

  /// Notify property changed information to the observers.
  void notifyPropertyChanged(PropertyChangedInfo info) {
    for (final observer in this._observers) {
      observer.call(info);
    }
  }
}
