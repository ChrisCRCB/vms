import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../widgets/new_button.dart';
import '../widgets/tabs/groups_tab.dart';
import '../widgets/tabs/subjects_tab.dart';
import '../widgets/tabs/volunteers_tab.dart';
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
              newCallback: createVolunteer,
              child: const VolunteersTab(),
            ),
            floatingActionButton: NewButton(
              onPressed: createVolunteer,
              tooltip: 'New Volunteer',
            ),
          ),
          TabbedScaffoldTab(
            title: 'Groups',
            icon: const Text('CRCB groups and sessions'),
            builder: (final context) => const GroupsTab(),
          ),
          TabbedScaffoldTab(
            title: 'Subjects',
            icon: const Text('The created subjects'),
            builder: (final context) => const SubjectsTab(),
          ),
        ],
      );

  /// Create a new volunteer.
  Future<void> createVolunteer() async {
    final database = await ref.read(databaseProvider.future);
    final volunteer = await database.volunteersDao.createVolunteer('No Name');
    ref.invalidate(volunteersProvider);
    if (mounted) {
      await pushWidget(
        context: context,
        builder: (final context) =>
            EditVolunteerScreen(volunteerId: volunteer.id),
      );
    }
  }
}
