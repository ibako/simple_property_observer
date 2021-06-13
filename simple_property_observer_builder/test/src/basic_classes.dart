part of 'test_input.dart';

@ShouldGenerate(r'''
mixin _ObservableMembers on PropertyObservable {}
''')
@propertyObservable
class NotAnnotatedGetter {
  String? get prop => null;
}

@ShouldGenerate(r'''
mixin _ObservableMembers on PropertyObservable {
  String? __prop;
  set _prop(String? value) {
    if (__prop == value) {
      return;
    }
    final oldValue = __prop;
    __prop = value;
    notifyPropertyChanged(PropertyChangedInfo('prop', oldValue, __prop));
  }
}
''')
@propertyObservable
class PrivateSetter {
  @observableWithPrivateSetter
  String? get prop => null;
}

@ShouldGenerate(r'''
mixin _ObservableMembers on PropertyObservable {
  String? __prop;
  set prop(String? value) {
    if (__prop == value) {
      return;
    }
    final oldValue = __prop;
    __prop = value;
    notifyPropertyChanged(PropertyChangedInfo('prop', oldValue, __prop));
  }
}
''')
@propertyObservable
class PublicSetter {
  @observable
  String? get prop => null;
}
