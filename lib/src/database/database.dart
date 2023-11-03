import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'daos/groups_dao.dart';
import 'daos/subjects_dao.dart';
import 'daos/volunteer_groups_dao.dart';
import 'daos/volunteer_subjects_dao.dart';
import 'daos/volunteer_subjects_types_dao.dart';
import 'daos/volunteers_dao.dart';
import 'tables/groups.dart';
import 'tables/subjects.dart';
import 'tables/volunteer_groups.dart';
import 'tables/volunteer_subject_types.dart';
import 'tables/volunteer_subjects.dart';
import 'tables/volunteers.dart';

part 'database.g.dart';

/// The top-level database class.
@DriftDatabase(
  tables: [
    Volunteers,
    Subjects,
    VolunteerSubjects,
    VolunteerSubjectTypes,
    Groups,
    VolunteerGroups,
  ],
  daos: [
    VolunteersDao,
    SubjectsDao,
    VolunteerSubjectsDao,
    VolunteerSubjectTypesDao,
    GroupsDao,
    VolunteerGroupsDao,
  ],
)
class VolunteerDatabase extends _$VolunteerDatabase {
  /// Create an instance.
  VolunteerDatabase(final File file) : super(NativeDatabase(file));
  @override
  int get schemaVersion => 1;

  /// Perform migration.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (final details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (final m) => m.createAll(),
        onUpgrade: (final m, final from, final to) async {},
      );
}
