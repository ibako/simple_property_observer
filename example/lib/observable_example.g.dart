part of 'observable_example.dart';

mixin _ObservableExamplePropertyObservable {
  final _observerHolder = ObserverHolder();

  /// Register a property changes observer.
  void registerObserver(PropertyChangedCallback observer) =>
      _observerHolder.register(observer);

  /// Unregister a property changes observer.
  void unregisterObserver(PropertyChangedCallback observer) =>
      _observerHolder.unregister(observer);

  String? __observableString1;

  /// **Public** setter is auto generated.
  set observableString1(String? value) {
    if (__observableString1 == value) {
      return;
    }
    final oldValue = __observableString1;
    __observableString1 = value;
    _observerHolder.notify(PropertyChangedInfo(
        'observableString1', oldValue, __observableString1));
  }

  String? __observableString2;

  /// **Private** setter is auto generated.
  set _observableString2(String? value) {
    if (__observableString2 == value) {
      return;
    }
    final oldValue = __observableString2;
    _observableString2 = value;
    _observerHolder.notify(PropertyChangedInfo(
        'observableString2', oldValue, __observableString2));
  }
}