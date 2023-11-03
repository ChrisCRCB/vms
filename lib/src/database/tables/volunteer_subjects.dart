import 'package:drift/drift.dart';

import 'mixins.dart';
import 'subjects.dart';
import 'volunteer_subject_types.dart';
import 'volunteers.dart';

/// A table for linking [Volunteers] to [Subjects].
class VolunteerSubjects extends Table with IdMixin {
  /// The ID of the volunteer to use.
  IntColumn get volunteerId =>
      integer().references(Volunteers, #id, onDelete: KeyAction.cascade)();

  /// The ID of the subject to link to the volunteer.
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.cascade)();

  /// The type of the subject.
  IntColumn get subjectTypeId => integer()
      .references(VolunteerSubjectTypes, #id, onDelete: KeyAction.restrict)
      .nullable()();
}
