import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/volunteers.dart';

part 'volunteers_dao.g.dart';

/// The volunteers DAO.
@DriftAccessor(tables: [Volunteers])
class VolunteersDao extends DatabaseAccessor<VolunteerDatabase>
    with _$VolunteersDaoMixin {
  /// Create an instance.
  VolunteersDao(super.db);

  /// Create a new volunteer with [name].
  Future<Volunteer> createVolunteer(
    final String name,
  ) =>
      into(volunteers).insertReturning(VolunteersCompanion(name: Value(name)));

  /// Update [volunteer].
  Future<Volunteer> editVolunteer({
    required final Volunteer volunteer,
    required final VolunteersCompanion companion,
  }) async {
    final query = update(volunteers)
      ..where((final table) => table.id.equals(volunteer.id));
    final rows = await query.writeReturning(companion);
    return rows.single;
  }

  /// Delete [volunteer].
  Future<int> deleteVolunteer(final Volunteer volunteer) => (delete(volunteers)
        ..where((final table) => table.id.equals(volunteer.id)))
      .go();

  /// Get a single row by [id].
  Future<Volunteer> getVolunteer(final int id) =>
      (select(volunteers)..where((final table) => table.id.equals(id)))
          .getSingle();

  /// Get all volunteers.
  Future<List<Volunteer>> getVolunteers() async => (select(volunteers)
        ..orderBy([(final table) => OrderingTerm.asc(table.name)]))
      .get();
}
