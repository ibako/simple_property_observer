part of 'observable_example.dart';

mixin _ObservableMembers on PropertyObservable {
  String? __observableString1;

  /// **Public** setter is auto generated.
  set observableString1(String? value) {
    if (__observableString1 == value) {
      return;
    }
    final oldValue = __observableString1;
    __observableString1 = value;
    notifyPropertyChanged(PropertyChangedInfo(
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
    notifyPropertyChanged(PropertyChangedInfo(
        'observableString2', oldValue, __observableString2));
  }
}
