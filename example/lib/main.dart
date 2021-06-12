import 'observable_example.dart';

/// A simple example
void main() {
  final observableExample = ObservableExample();

  // Observe property changes
  observableExample.registerObserver((info) {
    print('${info.name} changed: from ${info.oldValue} to ${info.newValue}');
  });

  print('set Apple');
  observableExample.observableString1 = 'Apple';

  print('set Banana');
  observableExample.observableString1 = 'Banana';

  // Shows the output below:
  // set Apple
  // observableString1 changed: from null to Apple
  // set Banana
  // observableString1 changed: from Apple to Banana
}
