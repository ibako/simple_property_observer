import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:simple_property_observer/simple_property_observer.dart';
import 'package:source_gen/source_gen.dart';

class PropertyObservableGenerator
    extends GeneratorForAnnotation<PropertyObservableMetadata> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '`@propertyObservable` can only be used on classes.',
        element: element,
      );
    }

    return _generateImpl(element);
  }

  String _generateImpl(ClassElement element) {
    final buffer = StringBuffer();
    buffer.writeln('mixin _ObservableMembers on PropertyObservable {');

    for (var field in element.fields) {
      //TODO write
    }

    buffer.writeln('}');

    return DartFormatter().format(buffer.toString());
  }
}
