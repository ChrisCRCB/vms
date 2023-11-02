import 'package:drift/drift.dart';

import '../database.dart';
import 'mixins.dart';
import 'subjects.dart';
import 'volunteers.dart';

/// The type of a [VolunteerSubject].
enum VolunteerSubjectType {
  /// Subject is of interest.
  ofInterest,

  /// Subject is a skill.
  skill,

  /// Subject is a no-go.
  noGo,
}

/// A table for linking [Volunteers] to [Subjects].
class VolunteerSubjects extends Table with IdMixin {
  /// The ID of the volunteer to use.
  IntColumn get volunteerId =>
      integer().references(Volunteers, #id, onDelete: KeyAction.cascade)();

  /// The ID of the subject to link to the volunteer.
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.cascade)();

  /// The type of the subject.
  IntColumn get subjectType => intEnum<VolunteerSubjectType>()
      .withDefault(Constant(VolunteerSubjectType.skill.index))();
}
