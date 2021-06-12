/// Metadata for a **getter** that can be observed.
///
/// Code generator finds this metadata, then generates a private instance
/// variable and a **public** setter.
/// In order to create a **private** setter, use [observableWithPrivateSetter]
/// instead.
const observable = const _ObservableMetadata(false);

/// Metadata for a **getter** that can be observed.
///
/// Code generator finds this metadata, then generates a private instance
/// variable and a **private** setter.
const observableWithPrivateSetter = const _ObservableMetadata(true);

class _ObservableMetadata {
  final isSetterPrivate;

  const _ObservableMetadata(this.isSetterPrivate);
}
