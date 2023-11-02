import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/volunteer_subjects.dart';

part 'volunteer_subjects_dao.g.dart';

/// The volunteer subjects DAO.
@DriftAccessor(tables: [VolunteerSubjects])
class VolunteerSubjectsDao extends DatabaseAccessor<VolunteerDatabase>
    with _$VolunteerSubjectsDaoMixin {
  /// Create an instance.
  VolunteerSubjectsDao(super.db);

  /// Add [subject] to [volunteer].
  Future<VolunteerSubject> createVolunteerSubject({
    required final Volunteer volunteer,
    required final Subject subject,
  }) =>
      into(volunteerSubjects).insertReturning(
        VolunteerSubjectsCompanion(
          subjectId: Value(subject.id),
          volunteerId: Value(volunteer.id),
        ),
      );

  /// Update [volunteerSubject].
  Future<VolunteerSubject> editVolunteerSubject({
    required final VolunteerSubject volunteerSubject,
    required final VolunteerSubjectsCompanion companion,
  }) async {
    final query = update(volunteerSubjects)
      ..where((final table) => table.id.equals(volunteerSubject.id));
    final rows = await query.writeReturning(companion);
    return rows.single;
  }

  /// Delete [volunteerSubject].
  Future<int> deleteVolunteerSubject(final VolunteerSubject volunteerSubject) =>
      (delete(volunteerSubjects)
            ..where((final table) => table.id.equals(volunteerSubject.id)))
          .go();

  /// Get a single row by [id].
  Future<VolunteerSubject> getVolunteerSubject(final int id) =>
      (select(volunteerSubjects)..where((final table) => table.id.equals(id)))
          .getSingle();

  /// Get all the subjects for [volunteer].
  Future<List<VolunteerSubject>> getSubjectsForVolunteer(
    final Volunteer volunteer,
  ) async =>
      (select(volunteerSubjects)
            ..where((final table) => table.volunteerId.equals(volunteer.id))
            ..orderBy([(final table) => OrderingTerm.asc(subjects.name)]))
          .get();
}
