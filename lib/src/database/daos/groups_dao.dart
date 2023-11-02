import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/groups.dart';

part 'groups_dao.g.dart';

/// The groups DAO.
@DriftAccessor(tables: [Groups])
class GroupsDao extends DatabaseAccessor<VolunteerDatabase>
    with _$GroupsDaoMixin {
  /// Create an instance.
  GroupsDao(super.db);

  /// Create a group with the given [name].
  Future<Group> createGroup(final String name) =>
      into(groups).insertReturning(GroupsCompanion(name: Value(name)));

  /// Update [group].
  Future<Group> editGroup({
    required final Group group,
    required final GroupsCompanion companion,
  }) async {
    final query = update(groups)
      ..where((final table) => table.id.equals(group.id));
    final rows = await query.writeReturning(companion);
    return rows.single;
  }

  /// Delete [group].
  Future<int> deleteGroup(final Group group) =>
      (delete(groups)..where((final table) => table.id.equals(group.id))).go();

  /// Get a single row by [id].
  Future<Group> getGroup(final int id) =>
      (select(groups)..where((final table) => table.id.equals(id))).getSingle();

  /// Get all groups.
  Future<List<Group>> getGroups() async =>
      (select(groups)..orderBy([(final table) => OrderingTerm.asc(table.name)]))
          .get();
}
