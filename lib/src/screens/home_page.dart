import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../widgets/new_button.dart';
import '../widgets/tabs/groups_tab.dart';
import '../widgets/tabs/subjects_tab.dart';
import '../widgets/tabs/volunteer_subject_types_tab.dart';
import '../widgets/tabs/volunteers_tab.dart';
import 'edit_group_screen.dart';
import 'edit_subject_screen.dart';
import 'edit_volunteer_screen.dart';

/// The home page for the app.
class HomePage extends ConsumerStatefulWidget {
  /// Create an instance.
  const HomePage({
    super.key,
  });

  /// Create state for this widget.
  @override
  HomePageState createState() => HomePageState();
}

/// State for [HomePage].
class HomePageState extends ConsumerState<HomePage> {
  /// Build a widget.
  @override
  Widget build(final BuildContext context) => TabbedScaffold(
        tabs: [
          TabbedScaffoldTab(
            title: 'Volunteers',
            icon: const Text('The volunteers in the database'),
            builder: (final context) => CommonShortcuts(
              newCallback: newVolunteer,
              child: const VolunteersTab(),
            ),
            floatingActionButton: NewButton(
              onPressed: newVolunteer,
              tooltip: 'New Volunteer',
            ),
          ),
          TabbedScaffoldTab(
            title: 'Groups',
            icon: const Text('Groups and sessions'),
            builder: (final context) => CommonShortcuts(
              newCallback: newGroup,
              child: const GroupsTab(),
            ),
            floatingActionButton: NewButton(
              onPressed: newGroup,
              tooltip: 'New Group',
            ),
          ),
          TabbedScaffoldTab(
            title: 'Subjects',
            icon: const Text('The created subjects'),
            builder: (final context) => CommonShortcuts(
              newCallback: newSubject,
              child: const SubjectsTab(),
            ),
            floatingActionButton: NewButton(
              onPressed: newSubject,
              tooltip: 'New Subject',
            ),
          ),
          TabbedScaffoldTab(
            title: 'Subject Types',
            icon: const Text('The created subject types'),
            builder: (final context) => CommonShortcuts(
              newCallback: newVolunteerSubjectType,
              child: const VolunteerSubjectTypesTab(),
            ),
            floatingActionButton: NewButton(
              onPressed: newVolunteerSubjectType,
              tooltip: 'New Subject Type',
            ),
          ),
        ],
      );

  /// Create a new volunteer.
  Future<void> newVolunteer() async {
    final database = await ref.read(databaseProvider.future);
    final volunteer = await database.volunteersDao.createVolunteer('No Name');
    ref.invalidate(volunteersProvider);
    if (mounted) {
      await pushWidget(
        context: context,
        builder: (final context) => EditVolunteerScreen(
          volunteerId: volunteer.id,
        ),
      );
    }
  }

  /// Create a new group.
  Future<void> newGroup() async {
    final database = await ref.read(databaseProvider.future);
    final group = await database.groupsDao.createGroup('Untitled Group');
    ref.invalidate(groupsProvider);
    if (mounted) {
      await pushWidget(
        context: context,
        builder: (final context) => EditGroupScreen(groupId: group.id),
      );
    }
  }

  /// Create a new subject.
  Future<void> newSubject() async {
    final database = await ref.read(databaseProvider.future);
    final subject =
        await database.subjectsDao.createSubject('Untitled Subject');
    ref.invalidate(subjectsProvider);
    if (mounted) {
      await pushWidget(
        context: context,
        builder: (final context) => EditSubjectScreen(subjectId: subject.id),
      );
    }
  }

  /// Create a new subject type.
  Future<void> newVolunteerSubjectType() => pushWidget(
        context: context,
        builder: (final context) => GetText(
          onDone: (final value) async {
            Navigator.pop(context);
            final database = await ref.read(databaseProvider.future);
            await database.volunteerSubjectTypesDao
                .createVolunteerSubjectType(value);
            ref.invalidate(volunteerSubjectTypesProvider);
          },
        ),
      );
}
