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
import '../widgets/new_button.dart';
import '../widgets/tabs/volunteers_tab.dart';

/// A screen for editing a group.
class EditGroupScreen extends ConsumerStatefulWidget {
  /// Create an instance.
  const EditGroupScreen({
    required this.groupId,
    super.key,
  });

  /// The ID of the group to edit.
  final int groupId;

  /// Create state for this widget.
  @override
  EditGroupScreenState createState() => EditGroupScreenState();
}

/// State for [EditGroupScreen].
class EditGroupScreenState extends ConsumerState<EditGroupScreen> {
  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final value = ref.watch(groupProvider.call(widget.groupId));
    return Cancel(
      child: value.when(
        data: (final group) => TabbedScaffold(
          tabs: [
            TabbedScaffoldTab(
              title: 'Group Details',
              icon: detailsIcon,
              builder: (final context) => ListView(
                children: [
                  TextListTile(
                    value: group.name,
                    onChanged: (final value) async {
                      final database = await ref.read(databaseProvider.future);
                      await database.groupsDao.editGroup(
                        group: group,
                        companion: GroupsCompanion(name: Value(value)),
                      );
                      ref
                        ..invalidate(groupsProvider)
                        ..invalidate(groupProvider.call(group.id));
                    },
                    header: 'Name',
                    autofocus: true,
                    validator: notEmptyValidator,
                  ),
                ],
              ),
            ),
            TabbedScaffoldTab(
              title: 'Volunteers',
              icon: Text('The volunteers who help out with ${group.name}'),
              builder: (final context) {
                final volunteersValue = ref.watch(
                  volunteersInGroupProvider.call(group),
                );
                return CommonShortcuts(
                  newCallback: addVolunteerToGroup,
                  child: volunteersValue.simpleWhen(
                    (final volunteers) => VolunteersTab(
                      volunteers: volunteers,
                      deleteVolunteer: (final context, final volunteer) async {
                        final database = await ref.read(
                          databaseProvider.future,
                        );
                        final volunteerGroup =
                            await (database.select(database.volunteerGroups)
                                  ..where(
                                    (final table) =>
                                        table.groupId.equals(group.id),
                                  )
                                  ..where(
                                    (final table) =>
                                        table.volunteerId.equals(volunteer.id),
                                  ))
                                .getSingleOrNull();
                        if (volunteerGroup != null) {
                          await database.volunteerGroupsDao
                              .deleteVolunteerGroup(volunteerGroup);
                          ref
                            ..invalidate(volunteersInGroupProvider.call(group))
                            ..invalidate(
                              volunteerGroupsProvider.call(volunteer),
                            );
                        }
                      },
                    ),
                  ),
                );
              },
              floatingActionButton: NewButton(
                onPressed: addVolunteerToGroup,
                tooltip: 'Add Volunteer',
              ),
            ),
          ],
        ),
        error: ErrorScreen.withPositional,
        loading: LoadingScreen.new,
      ),
    );
  }

  /// Add a new volunteer to the group.
  Future<void> addVolunteerToGroup() async {
    final group = await ref.read(groupProvider.call(widget.groupId).future);
    if (mounted) {
      await pushWidget(
        context: context,
        builder: (final context) {
          final volunteersValue = ref.watch(volunteersProvider);
          return volunteersValue.when(
            data: (final volunteers) => SelectItem(
              values: volunteers,
              onDone: (final volunteer) async {
                final database = await ref.read(databaseProvider.future);
                await database.volunteerGroupsDao.createVolunteerGroup(
                  volunteer: volunteer,
                  group: group,
                );
                ref
                  ..invalidate(groupProvider.call(group.id))
                  ..invalidate(
                    volunteersInGroupProvider.call(group),
                  );
              },
              getSearchString: (final volunteer) => volunteer.name,
              getWidget: (final volunteer) => Text(volunteer.name),
              title: 'Select Volunteer',
            ),
            error: ErrorScreen.withPositional,
            loading: LoadingScreen.new,
          );
        },
      );
    }
  }
}
