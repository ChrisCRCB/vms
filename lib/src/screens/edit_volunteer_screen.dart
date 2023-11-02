import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recase/recase.dart';

import '../constants.dart';
import '../database/database.dart';
import '../extensions.dart';
import '../providers/providers.dart';

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
              title: 'Details',
              icon: const Icon(Icons.details_rounded),
              builder: (final context) => ListView(
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
                  TextListTile(
                    value: volunteer.phoneNumber ?? unsetMessage,
                    onChanged: (final value) => editVolunteer(
                      ref,
                      VolunteersCompanion(
                        phoneNumber: Value(value.isEmpty ? null : value),
                      ),
                    ),
                    header: 'Phone Number',
                  ),
                  TextListTile(
                    value: volunteer.emailAddress ?? unsetMessage,
                    onChanged: (final value) => editVolunteer(
                      ref,
                      VolunteersCompanion(
                        emailAddress: Value(value.isEmpty ? null : value),
                      ),
                    ),
                    header: 'Email Address',
                  ),
                ],
              ),
            ),
            TabbedScaffoldTab(
              title: 'Groups',
              icon: const Text('The groups this volunteer helps out at'),
              builder: (final context) {
                final groupsValue = ref.watch(
                  volunteerGroupsProvider.call(volunteer),
                );
                return groupsValue.simpleWhen((final data) {
                  if (data.isEmpty) {
                    return CenterText(
                      text: '${volunteer.name} does not currently help out at '
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
                            ref.invalidate(
                              volunteerGroupsProvider.call(volunteer),
                            );
                          },
                          child: ListTile(
                            autofocus: index == 0,
                            title: Text(group.name),
                            onTap: () {},
                          ),
                        ),
                      );
                    },
                  );
                });
              },
            ),
            TabbedScaffoldTab(
              title: 'Subjects',
              icon: const Text('Volunteer subjects'),
              builder: (final context) {
                final subjectsValue = ref.watch(
                  volunteerSubjectsProvider.call(volunteer),
                );
                return subjectsValue.simpleWhen((final data) {
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
                      final typeName =
                          volunteerSubjectContext.type.name.titleCase;
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
                            onTap: () {},
                          ),
                        ),
                      );
                    },
                  );
                });
              },
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
}
