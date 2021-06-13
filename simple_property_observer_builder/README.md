# simple_property_observer_builder
Dart package for auto generating a property observable class.
This package is only for dev_environment.
See also `simple_property_observer` package.

# How to use
This repository consists of 2 packages, `simple_property_observer` and `simple_property_observer_builder`.
These packages can be used in pure Dart projects as well as Flutter.
`example` is a simple example of using these packages.

## Dependency settings
In your `pubspec.yaml`, write the below settings:

```yaml
dependencies:
  simple_property_observer: any

dev_dependencies:
  build_runner: any
  simple_property_observer_builder: any
```

`simple_property_observer` contains the definitions for the property observable pattern and the auto-generating annotations.

`simple_property_observer_builder` contains the command line tools for the auto-generating.

## Define your class
For example, write the below annotated class:

```Dart
import 'package:simple_property_observer/simple_property_observer.dart';

part 'example.g.dart';

@propertyObservable
class Example {
  @observable
  String? get observableProperty => null;
}
```

Dart Analysis will point out the error, but ignore it and proceed to the next step.

#### Points
- Annotate your **class** with `@propertyObservable` for auto-generating the property observable pattern.
- Create **GETTER** and annotate it with `@observable`.
- Write `part` sentence for the auto-generating file.

Then, run the build command in Terminal:

```bash
$ flutter packages pub run build_runner build
```

If you create a pure Dart project, run the below command:

```bash
$ dart run build_runner build
```

After finishing the command, you can see `example.g.dart` file:

```Dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// PropertyObservableGenerator
// **************************************************************************

mixin _ObservableMembers on PropertyObservable {
  String? __observableProperty;
  set observableProperty(String? value) {
    if (__observableProperty == value) {
      return;
    }
    final oldValue = __observableProperty;
    __observableProperty = value;
    notifyPropertyChanged(PropertyChangedInfo(
        'observableProperty', oldValue, __observableProperty));
  }
}
```

#### Point
Then, you must modify `example.dart` as below:

```Dart
import 'package:simple_property_observer/simple_property_observer.dart';

part 'example.g.dart';

@propertyObservable
class Example with PropertyObservable, _ObservableMembers {
  @observable
  String? get observableProperty => __observableProperty;
}
```

Add `with PropertyObservable, _ObservableMembers` and modify the getter from `null` to `__observableProperty`.

## Observe instances
You can observe the property changes with the `registerObserver` method:

```Dart
import 'example.dart';

void main() {
  final example = Example();

  // Observe property changes
  example.registerObserver((info) {
    print('${info.name} changed: from ${info.oldValue} to ${info.newValue}');
  });

  print('set Apple');
  example.observableProperty = 'Apple';

  print('set Banana');
  example.observableProperty = 'Banana';

  // Shows the output below:
  // set Apple
  // observableProperty changed: from null to Apple
  // set Banana
  // observableProperty changed: from Apple to Banana
}
```

You can also cancel observing with the `unregisterObserver` method.
