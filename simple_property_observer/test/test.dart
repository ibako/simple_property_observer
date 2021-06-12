import 'package:test/test.dart';
import 'package:simple_property_observer/simple_property_observer.dart';

class TestPropertyObservable with PropertyObservable {}

void main() {
  test('register and notify test', () {
    final observerHolder = TestPropertyObservable();
    var value = 0;
    observerHolder.registerObserver((info) {
      value = info.newValue;
    });

    expect(value, 0);
    observerHolder
        .notifyPropertyChanged(PropertyChangedInfo('value', value, 1));
    expect(value, 1);
  });

  test('unregister test', () {
    final observerHolder = TestPropertyObservable();
    var value = 0;
    PropertyChangedCallback callback = (info) {
      value = info.newValue;
    };
    observerHolder.registerObserver(callback);

    expect(value, 0);
    observerHolder
        .notifyPropertyChanged(PropertyChangedInfo('value', value, 1));
    expect(value, 1);
    observerHolder.unregisterObserver(callback);
    observerHolder
        .notifyPropertyChanged(PropertyChangedInfo('value', value, 2));
    expect(value, 1);
  });
}
