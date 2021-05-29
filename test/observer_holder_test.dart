import 'package:test/test.dart';
import 'package:simple_property_observer/simple_property_observer.dart';

void main() {
  test('register and notify test', () {
    final observerHolder = ObserverHolder();
    var value = 0;
    observerHolder.register((info) {
      value = info.newValue;
    });

    expect(value, 0);
    observerHolder.notify(PropertyChangedInfo('value', value, 1));
    expect(value, 1);
  });

  test('unregister test', () {
    final observerHolder = ObserverHolder();
    var value = 0;
    PropertyChangedCallback callback = (info) {
      value = info.newValue;
    };
    observerHolder.register(callback);

    expect(value, 0);
    observerHolder.notify(PropertyChangedInfo('value', value, 1));
    expect(value, 1);
    observerHolder.unregister(callback);
    observerHolder.notify(PropertyChangedInfo('value', value, 2));
    expect(value, 1);
  });
}
