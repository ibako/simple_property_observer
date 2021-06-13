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
      final getter = field.getter;
      if (getter == null) {
        continue;
      }
      final metadataList = getter.metadata;
      if (metadataList.length == 0) {
        continue;
      }

      for (var metadata in metadataList) {
        final source = metadata.toSource();
        if (source == '@observableWithPrivateSetter') {
          _generateField(buffer, getter);
          _generatePrivateSetterDeclaration(buffer, getter);
          _generateSetterProcess(buffer, getter);
          break;
        } else if (source == '@observable') {
          _generateField(buffer, getter);
          _generatePublicSetterDeclaration(buffer, getter);
          _generateSetterProcess(buffer, getter);
          break;
        }
      }
    }

    buffer.writeln('}');

    return DartFormatter().format(buffer.toString());
  }

  void _generateField(StringBuffer buffer, PropertyAccessorElement element) {
    final type = element.returnType.toString();
    final name = '__${element.name}';
    buffer.writeln('  $type $name;');
  }

  void _generatePrivateSetterDeclaration(
      StringBuffer buffer, PropertyAccessorElement element) {
    final type = element.returnType.toString();
    final name = '_${element.name}';
    buffer.writeln('  set $name($type value) {');
  }

  void _generatePublicSetterDeclaration(
      StringBuffer buffer, PropertyAccessorElement element) {
    final type = element.returnType.toString();
    final name = '${element.name}';
    buffer.writeln('  set $name($type value) {');
  }

  void _generateSetterProcess(
      StringBuffer buffer, PropertyAccessorElement element) {
    final getterName = element.name;
    final fieldName = '__${element.name}';
    buffer
      ..writeln('  if ($fieldName == value) {')
      ..writeln('    return;')
      ..writeln('  }')
      ..writeln('  final oldValue = $fieldName;')
      ..writeln('  $fieldName = value;')
      ..writeln('  notifyPropertyChanged(PropertyChangedInfo(')
      ..writeln('    \'$getterName\', oldValue, $fieldName));')
      ..writeln('}');
  }
}
