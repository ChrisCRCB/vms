import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/volunteer_groups.dart';

part 'volunteer_groups_dao.g.dart';

/// The volunteer groups DAO.
@DriftAccessor(tables: [VolunteerGroups])
class VolunteerGroupsDao extends DatabaseAccessor<VolunteerDatabase>
    with _$VolunteerGroupsDaoMixin {
  /// Create an instance.
  VolunteerGroupsDao(super.db);

  /// Create a connection between [volunteer] and [group].
  Future<VolunteerGroup> createVolunteerGroup({
    required final Volunteer volunteer,
    required final Group group,
  }) =>
      into(volunteerGroups).insertReturning(
        VolunteerGroupsCompanion(
          groupId: Value(group.id),
          volunteerId: Value(volunteer.id),
        ),
      );

  /// Update [volunteerGroup].
  Future<VolunteerGroup> editVolunteerGroup({
    required final VolunteerGroup volunteerGroup,
    required final VolunteerGroupsCompanion companion,
  }) async {
    final query = update(volunteerGroups)
      ..where((final table) => table.id.equals(volunteerGroup.id));
    final rows = await query.writeReturning(companion);
    return rows.single;
  }

  /// Delete [volunteerGroup].
  Future<int> deleteVolunteerGroup(final VolunteerGroup volunteerGroup) =>
      (delete(volunteerGroups)
            ..where((final table) => table.id.equals(volunteerGroup.id)))
          .go();

  /// Get a single row by [id].
  Future<VolunteerGroup> getVolunteerGroup(final int id) =>
      (select(volunteerGroups)..where((final table) => table.id.equals(id)))
          .getSingle();

  /// Get the groups for [volunteer].
  Future<List<VolunteerGroup>> getGroupsForVolunteer(
    final Volunteer volunteer,
  ) async =>
      (select(volunteerGroups)
            ..where((final table) => table.volunteerId.equals(volunteer.id))
            ..orderBy([(final table) => OrderingTerm.asc(groups.name)]))
          .get();
}
