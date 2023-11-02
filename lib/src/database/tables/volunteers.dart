import 'package:drift/drift.dart';

import 'mixins.dart';

/// The volunteers table.
class Volunteers extends Table with IdMixin, NameMixin {
  /// The volunteer's phone number.
  TextColumn get phoneNumber => text().nullable()();

  /// The volunteer's email address.
  TextColumn get emailAddress => text().nullable()();
}
