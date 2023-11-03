import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../database/database.dart';
import 'volunteer_group_context.dart';
import 'volunteer_subject_context.dart';

/// Provide the application documents directory.
final applicationDocumentsDirectoryProvider = FutureProvider<Directory>(
  (final ref) => getApplicationDocumentsDirectory(),
);

/// Provide the database.
final databaseProvider = FutureProvider<VolunteerDatabase>((final ref) async {
  final documentsDirectory =
      await ref.watch(applicationDocumentsDirectoryProvider.future);
  final directory = Directory(path.join(documentsDirectory.path, 'vms'));
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }
  final file = File(path.join(directory.path, 'db.sqlite3'));
  return VolunteerDatabase(file);
});

/// Provide all volunteers.
final volunteersProvider = FutureProvider<List<Volunteer>>((final ref) async {
  final database = await ref.watch(databaseProvider.future);
  return database.volunteersDao.getVolunteers();
});

/// Provide a single volunteer.
final volunteerProvider =
    FutureProvider.family<Volunteer, int>((final ref, final id) async {
  final database = await ref.watch(databaseProvider.future);
  return database.volunteersDao.getVolunteer(id);
});

/// Get all subjects in the database.
final subjectsProvider = FutureProvider<List<Subject>>((final ref) async {
  final database = await ref.watch(databaseProvider.future);
  return database.subjectsDao.getSubjects();
});

/// Get the subjects for a particular volunteer.
final volunteerSubjectsProvider =
    FutureProvider.family<List<VolunteerSubjectContext>, Volunteer>(
        (final ref, final volunteer) async {
  final database = await ref.watch(databaseProvider.future);
  final query = database.select(database.volunteerSubjects).join([
    innerJoin(
      database.subjects,
      database.subjects.id.equalsExp(database.volunteerSubjects.subjectId),
    ),
    leftOuterJoin(
      database.volunteerSubjectTypes,
      database.volunteerSubjectTypes.id.equalsExp(
        database.volunteerSubjects.subjectTypeId,
      ),
    ),
  ])
    ..where(database.volunteerSubjects.volunteerId.equals(volunteer.id))
    ..orderBy([OrderingTerm.asc(database.subjects.name)]);
  final results = await query.get();
  return results.map(
    (final e) {
      final volunteerSubject = e.readTable(database.volunteerSubjects);
      return VolunteerSubjectContext(
        volunteer: volunteer,
        volunteerSubject: volunteerSubject,
        subject: e.readTable(database.subjects),
        type: e.readTableOrNull(database.volunteerSubjectTypes),
      );
    },
  ).toList();
});

/// Get all groups in the database.
final groupsProvider = FutureProvider<List<Group>>((final ref) async {
  final database = await ref.watch(databaseProvider.future);
  return database.groupsDao.getGroups();
});

/// Get the groups for a particular volunteer.
final volunteerGroupsProvider =
    FutureProvider.family<List<VolunteerGroupContext>, Volunteer>(
        (final ref, final volunteer) async {
  final database = await ref.watch(databaseProvider.future);
  final query = database.select(database.volunteerGroups).join([
    innerJoin(
      database.groups,
      database.groups.id.equalsExp(database.volunteerGroups.groupId),
    ),
  ])
    ..where(database.volunteerGroups.volunteerId.equals(volunteer.id))
    ..orderBy([OrderingTerm.asc(database.groups.name)]);
  final results = await query.get();
  return results
      .map(
        (final e) => VolunteerGroupContext(
          volunteer: volunteer,
          volunteerGroup: e.readTable(database.volunteerGroups),
          group: e.readTable(database.groups),
        ),
      )
      .toList();
});

/// Provide a single group.
final groupProvider =
    FutureProvider.family<Group, int>((final ref, final id) async {
  final database = await ref.watch(databaseProvider.future);
  return database.groupsDao.getGroup(id);
});

/// Provide a single subject.
final subjectProvider =
    FutureProvider.family<Subject, int>((final ref, final id) async {
  final database = await ref.watch(databaseProvider.future);
  return database.subjectsDao.getSubject(id);
});

/// Provide all the volunteers in a particular group.
final volunteersInGroupProvider = FutureProvider.family<List<Volunteer>, Group>(
    (final ref, final group) async {
  final database = await ref.watch(databaseProvider.future);
  return database.volunteerGroupsDao.getVolunteersInGroup(group);
});

/// Provide the volunteers with a particular subject.
final volunteersWithSubjectProvider =
    FutureProvider.family<List<VolunteerSubjectContext>, Subject>(
        (final ref, final subject) async {
  final database = await ref.watch(databaseProvider.future);
  return database.volunteerSubjectsDao.getVolunteersWithSubject(subject);
});

/// Provide all volunteer subject types.
final volunteerSubjectTypesProvider =
    FutureProvider<List<VolunteerSubjectType>>((final ref) async {
  final database = await ref.watch(databaseProvider.future);
  return database.volunteerSubjectTypesDao.getVolunteerSubjectTypes();
});

/// Provide a single volunteer subject type.
final volunteerSubjectTypeProvider =
    FutureProvider.family<VolunteerSubjectType, int>(
        (final ref, final id) async {
  final database = await ref.watch(databaseProvider.future);
  return database.volunteerSubjectTypesDao.getVolunteerSubjectType(id);
});
