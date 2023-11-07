import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../database/database.dart';
import '../extensions.dart';
import '../providers/providers.dart';
import '../widgets/launch_url_widget.dart';
import '../widgets/new_button.dart';
import 'edit_group_screen.dart';
import 'select_volunteer_subject_type.dart';

/// The screen for editing a volunteer.
class EditVolunteerScreen extends ConsumerWidget {
  /// Create an instance.
  const EditVolunteerScreen({
    required this.volunteerId,
    super.key,
  });

  /// The ID of the volunteer to edit.
  final int volunteerId;

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final value = ref.watch(volunteerProvider.call(volunteerId));
    return Cancel(
      child: value.when(
        data: (final volunteer) => TabbedScaffold(
          tabs: [
            TabbedScaffoldTab(
              title: 'Volunteer Details',
              icon: detailsIcon,
              builder: (final context) {
                final phoneNumber = volunteer.phoneNumber;
                final emailAddress = volunteer.emailAddress;
                return ListView(
                  children: [
                    TextListTile(
                      value: volunteer.name,
                      onChanged: (final value) => editVolunteer(
                        ref,
                        VolunteersCompanion(name: Value(value)),
                      ),
                      header: 'Name',
                      autofocus: true,
                    ),
                    LaunchUrlWidget(
                      url: phoneNumber == null ? null : 'tel:$phoneNumber',
                      child: TextListTile(
                        value: phoneNumber ?? unsetMessage,
                        onChanged: (final value) => editVolunteer(
                          ref,
                          VolunteersCompanion(
                            phoneNumber: Value(value.isEmpty ? null : value),
                          ),
                        ),
                        header: 'Phone Number',
                      ),
                    ),
                    LaunchUrlWidget(
                      url: emailAddress == null ? null : 'mailto:$emailAddress',
                      child: TextListTile(
                        value: emailAddress ?? unsetMessage,
                        onChanged: (final value) => editVolunteer(
                          ref,
                          VolunteersCompanion(
                            emailAddress: Value(value.isEmpty ? null : value),
                          ),
                        ),
                        header: 'Email Address',
                      ),
                    ),
                  ],
                );
              },
            ),
            TabbedScaffoldTab(
              title: 'Groups',
              icon: Text('The groups ${volunteer.name} helps out at'),
              builder: (final context) {
                final groupsValue = ref.watch(
                  volunteerGroupsProvider.call(volunteer),
                );
                return CommonShortcuts(
                  newCallback: () => addGroup(context, ref),
                  child: groupsValue.simpleWhen((final data) {
                    if (data.isEmpty) {
                      return CenterText(
                        text:
                            '${volunteer.name} does not currently help out at '
                            'any groups.',
                        autofocus: true,
                      );
                    }
                    return BuiltSearchableListView(
                      items: data,
                      builder: (final context, final index) {
                        final volunteerGroupContext = data[index];
                        final group = volunteerGroupContext.group;
                        return SearchableListTile(
                          searchString: group.name,
                          child: CommonShortcuts(
                            deleteCallback: () async {
                              final database = await ref.read(
                                databaseProvider.future,
                              );
                              await database.volunteerGroupsDao
                                  .deleteVolunteerGroup(
                                volunteerGroupContext.volunteerGroup,
                              );
                              ref
                                ..invalidate(
                                  volunteerGroupsProvider.call(volunteer),
                                )
                                ..invalidate(
                                  volunteersInGroupProvider.call(group),
                                );
                            },
                            child: ListTile(
                              autofocus: index == 0,
                              title: Text(group.name),
                              onTap: () => pushWidget(
                                context: context,
                                builder: (final context) => EditGroupScreen(
                                  groupId: group.id,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                );
              },
              floatingActionButton: NewButton(
                onPressed: () => addGroup(context, ref),
                tooltip: 'Add Group',
              ),
            ),
            TabbedScaffoldTab(
              title: 'Subjects',
              icon: Text("${volunteer.name}'s subjects"),
              builder: (final context) {
                final subjectsValue = ref.watch(
                  volunteerSubjectsProvider.call(volunteer),
                );
                return CommonShortcuts(
                  newCallback: () => addSubject(context, ref),
                  child: subjectsValue.simpleWhen((final data) {
                    if (data.isEmpty) {
                      return const CenterText(
                        text: 'No subjects have been added.',
                        autofocus: true,
                      );
                    }
                    return BuiltSearchableListView(
                      items: data,
                      builder: (final context, final index) {
                        final volunteerSubjectContext = data[index];
                        final subject = volunteerSubjectContext.subject;
                        final type = volunteerSubjectContext.type ??
                            unsetVolunteerSubjectType;
                        final typeName = type.name;
                        return SearchableListTile(
                          searchString: subject.name,
                          child: CommonShortcuts(
                            deleteCallback: () async {
                              final database = await ref.read(
                                databaseProvider.future,
                              );
                              await database.volunteerSubjectsDao
                                  .deleteVolunteerSubject(
                                volunteerSubjectContext.volunteerSubject,
                              );
                              ref.invalidate(
                                volunteerSubjectsProvider.call(volunteer),
                              );
                            },
                            child: ListTile(
                              autofocus: index == 0,
                              title: Text(subject.name),
                              subtitle: Text(typeName),
                              onTap: () => pushWidget(
                                context: context,
                                builder: (final context) =>
                                    SelectVolunteerSubjectType(
                                  onChanged: (final value) async {
                                    final database = await ref.read(
                                      databaseProvider.future,
                                    );
                                    await database.volunteerSubjectsDao
                                        .editVolunteerSubject(
                                      volunteerSubject: volunteerSubjectContext
                                          .volunteerSubject,
                                      companion: VolunteerSubjectsCompanion(
                                        subjectTypeId: Value(value.id),
                                      ),
                                    );
                                    ref
                                      ..invalidate(
                                        volunteerSubjectsProvider.call(
                                          volunteer,
                                        ),
                                      )
                                      ..invalidate(
                                        volunteersWithSubjectProvider.call(
                                          subject,
                                        ),
                                      );
                                  },
                                  volunteerSubjectType: type,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                );
              },
              floatingActionButton: NewButton(
                onPressed: () => addSubject(context, ref),
                tooltip: 'Add Subject',
              ),
            ),
          ],
        ),
        error: ErrorScreen.withPositional,
        loading: LoadingScreen.new,
      ),
    );
  }

  /// Edit the current volunteer.
  Future<void> editVolunteer(
    final WidgetRef ref,
    final VolunteersCompanion companion,
  ) async {
    final volunteer =
        await ref.read(volunteerProvider.call(volunteerId).future);
    final database = await ref.read(databaseProvider.future);
    await database.volunteersDao
        .editVolunteer(volunteer: volunteer, companion: companion);
    ref
      ..invalidate(volunteerProvider.call(volunteerId))
      ..invalidate(volunteersProvider);
  }

  /// Add a group to the volunteer.
  Future<void> addGroup(final BuildContext context, final WidgetRef ref) =>
      pushWidget(
        context: context,
        builder: (final context) {
          final groupsValue = ref.read(groupsProvider);
          return groupsValue.when(
            data: (final groups) => SelectItem<Group>(
              values: groups,
              getSearchString: (final group) => group.name,
              title: 'Select Group',
              getWidget: (final group) => Text(group.name),
              onDone: (final group) async {
                final volunteer = await ref.read(
                  volunteerProvider.call(volunteerId).future,
                );
                final database = await ref.read(
                  databaseProvider.future,
                );
                await database.volunteerGroupsDao.createVolunteerGroup(
                  volunteer: volunteer,
                  group: group,
                );
                ref.invalidate(
                  volunteerGroupsProvider.call(volunteer),
                );
              },
            ),
            error: ErrorScreen.withPositional,
            loading: LoadingScreen.new,
          );
        },
      );

  /// Add a subject to the volunteer.
  Future<void> addSubject(final BuildContext context, final WidgetRef ref) =>
      pushWidget(
        context: context,
        builder: (final context) {
          final subjectsValue = ref.read(subjectsProvider);
          return subjectsValue.when(
            data: (final subjects) => SelectItem<Subject>(
              values: subjects,
              getSearchString: (final subject) => subject.name,
              title: 'Select Subject',
              getWidget: (final subject) => Text(subject.name),
              onDone: (final subject) async {
                final volunteer = await ref.read(
                  volunteerProvider.call(volunteerId).future,
                );
                final database = await ref.read(
                  databaseProvider.future,
                );
                await database.volunteerSubjectsDao.createVolunteerSubject(
                  volunteer: volunteer,
                  subject: subject,
                );
                ref.invalidate(
                  volunteerSubjectsProvider.call(volunteer),
                );
              },
            ),
            error: ErrorScreen.withPositional,
            loading: LoadingScreen.new,
          );
        },
      );
}
