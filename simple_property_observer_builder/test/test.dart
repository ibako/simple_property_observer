import 'package:path/path.dart' as path;
import 'package:simple_property_observer_builder/src/property_observable_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  initializeBuildLogTracking();
  final reader = await initializeLibraryReaderForDirectory(
      path.join('test', 'src'), 'test_input.dart');

  testAnnotatedElements(reader, PropertyObservableGenerator(),
      expectedAnnotatedTests: _expectedAnnotatedTests);
}

const _expectedAnnotatedTests = {
  'NotAnnotatedGetter',
  'PrivateSetter',
  'PublicSetter',
};
