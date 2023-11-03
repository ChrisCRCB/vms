import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/volunteer_subject_types.dart';

part 'volunteer_subjects_types_dao.g.dart';

/// The volunteer subject types DAO.
@DriftAccessor(tables: [VolunteerSubjectTypes])
class VolunteerSubjectTypesDao extends DatabaseAccessor<VolunteerDatabase>
    with _$VolunteerSubjectTypesDaoMixin {
  /// Create an instance.
  VolunteerSubjectTypesDao(super.db);

  /// Create a new subject type with the given [name].
  Future<VolunteerSubjectType> createVolunteerSubjectType(final String name) =>
      into(volunteerSubjectTypes).insertReturning(
        VolunteerSubjectTypesCompanion(name: Value(name)),
      );

  /// Update [volunteerSubjectType].
  Future<VolunteerSubjectType> editVolunteerSubjectType({
    required final VolunteerSubjectType volunteerSubjectType,
    required final VolunteerSubjectTypesCompanion companion,
  }) async {
    final query = update(volunteerSubjectTypes)
      ..where((final table) => table.id.equals(volunteerSubjectType.id));
    final rows = await query.writeReturning(companion);
    return rows.single;
  }

  /// Delete [volunteerSubjectType].
  Future<int> deleteVolunteerSubjectType(
    final VolunteerSubjectType volunteerSubjectType,
  ) =>
      (delete(volunteerSubjectTypes)
            ..where((final table) => table.id.equals(volunteerSubjectType.id)))
          .go();

  /// Get a single row by [id].
  Future<VolunteerSubjectType> getVolunteerSubjectType(final int id) =>
      (select(volunteerSubjectTypes)
            ..where((final table) => table.id.equals(id)))
          .getSingle();

  /// Return all volunteer subject types.
  Future<List<VolunteerSubjectType>> getVolunteerSubjectTypes() async =>
      (select(volunteerSubjectTypes)
            ..orderBy(
              [(final table) => OrderingTerm.asc(volunteerSubjectTypes.name)],
            ))
          .get();
}
