/// Information of property changes.
class PropertyChangedInfo<T> {
  /// Property name.
  final String name;

  /// Old property value.
  final T oldValue;

  /// New property value.
  final T newValue;

  /// Creates [PropertyChangedInfo].
  const PropertyChangedInfo(this.name, this.oldValue, this.newValue);
}

/// The function type that is called when a property changes.
typedef PropertyChangedCallback = void Function(PropertyChangedInfo info);
