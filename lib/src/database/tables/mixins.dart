import 'package:drift/drift.dart';

/// Add a [id] field.
mixin IdMixin on Table {
  /// The primary key for this table.
  IntColumn get id => integer().autoIncrement()();
}

/// Add a [name] field.
mixin NameMixin on Table {
  /// The name of something.
  TextColumn get name => text()();
}
