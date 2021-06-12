import 'package:simple_property_observer/simple_property_observer.dart';

part 'observable_example.g.dart';

/// An example of [PropertyObservable] class.
@propertyObservable
class ObservableExample with PropertyObservable, _ObservableMembers {
  /// **Public** setter is auto generated.
  @observable
  String? get observableString1 => __observableString1;

  /// **Private** setter is auto generated.
  @observableWithPrivateSetter
  String? get observableString2 => __observableString2;

  /// You can also declare unobservable properties.
  String? get unobservableString => _unobservableString;
  String? _unobservableString;
}
