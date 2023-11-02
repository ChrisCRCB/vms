import 'package:drift/drift.dart';

import 'groups.dart';
import 'mixins.dart';
import 'volunteers.dart';

/// The volunteer groups table.
class VolunteerGroups extends Table with IdMixin {
  /// The ID of the volunteer to use.
  IntColumn get volunteerId =>
      integer().references(Volunteers, #id, onDelete: KeyAction.cascade)();

  /// The ID of the group to link to the volunteer.
  IntColumn get groupId =>
      integer().references(Groups, #id, onDelete: KeyAction.cascade)();
}
