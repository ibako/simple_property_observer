part of 'test_input.dart';

@ShouldGenerate(r'''
mixin _ObservableMembers on PropertyObservable {}
''')
@propertyObservable
class NotAnnotatedGetter {
  String? get prop => null;
}
