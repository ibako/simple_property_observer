part of 'test_input.dart';

@ShouldGenerate(r'''
mixin _ObservableMembers on PropertyObservable {
  String? __prop;

  /// Documentation Comment
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
class DocumentationCommentOneLine {
  /// Documentation Comment
  @observable
  String? get prop => null;
}

@ShouldGenerate(r'''
mixin _ObservableMembers on PropertyObservable {
  String? __prop;

  /// Documentation
  /// Comment
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
class DocumentationCommentMultiLine {
  /// Documentation
  /// Comment
  @observable
  String? get prop => null;
}
