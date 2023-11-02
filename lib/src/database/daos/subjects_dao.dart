import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/subjects.dart';

part 'subjects_dao.g.dart';

/// The subjects DAO.
@DriftAccessor(tables: [Subjects])
class SubjectsDao extends DatabaseAccessor<VolunteerDatabase>
    with _$SubjectsDaoMixin {
  /// Create an instance.
  SubjectsDao(super.db);

  /// Create a new subject with the given [name].
  Future<Subject> createSubject(final String name) =>
      into(subjects).insertReturning(SubjectsCompanion(name: Value(name)));

  /// Update [subject].
  Future<Subject> editSubject({
    required final Subject subject,
    required final SubjectsCompanion companion,
  }) async {
    final query = update(subjects)
      ..where((final table) => table.id.equals(subject.id));
    final rows = await query.writeReturning(companion);
    return rows.single;
  }

  /// Delete [subject].
  Future<int> deleteSubject(final Subject subject) =>
      (delete(subjects)..where((final table) => table.id.equals(subject.id)))
          .go();

  /// Get a single row by [id].
  Future<Subject> getSubject(final int id) =>
      (select(subjects)..where((final table) => table.id.equals(id)))
          .getSingle();

  /// Get all subjects.
  Future<List<Subject>> getSubjects() async => (select(subjects)
        ..orderBy([(final table) => OrderingTerm.asc(table.name)]))
      .get();
}
