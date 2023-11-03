import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../database/database.dart';
import '../../extensions.dart';
import '../../providers/providers.dart';
import '../../screens/edit_volunteer_screen.dart';

/// The volunteers tab.
class VolunteersTab extends ConsumerWidget {
  /// Create an instance.
  const VolunteersTab({
    this.volunteers,
    this.deleteVolunteer,
    super.key,
  });

  /// The volunteers to show.
  final List<Volunteer>? volunteers;

  /// The function to call to delete a volunteer.
  ///
  /// By default, this function deletes the volunteer.
  final Future<void> Function(BuildContext context, Volunteer volunteer)?
      deleteVolunteer;

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final v = volunteers;
    if (v == null) {
      final value = ref.watch(volunteersProvider);
      return value.simpleWhen((final data) => getWidget(ref, data));
    }
    return getWidget(ref, v);
  }

  /// Get he widget.
  Widget getWidget(final WidgetRef ref, final List<Volunteer> data) {
    if (data.isEmpty) {
      return const CenterText(
        text: 'No volunteers to show.',
        autofocus: true,
      );
    }
    return BuiltSearchableListView(
      items: data,
      builder: (final context, final index) {
        final volunteer = data[index];
        return SearchableListTile(
          searchString: volunteer.name,
          child: CommonShortcuts(
            deleteCallback: () {
              final f = deleteVolunteer;
              if (f == null) {
                confirm(
                  context: context,
                  message: 'Delete ${volunteer.name}?',
                  title: confirmDeleteTitle,
                  yesCallback: () async {
                    Navigator.pop(context);
                    final database = await ref.read(
                      databaseProvider.future,
                    );
                    await database.volunteersDao.deleteVolunteer(volunteer);
                    ref.invalidate(volunteersProvider);
                  },
                );
              } else {
                f(context, volunteer);
              }
            },
            child: ListTile(
              autofocus: index == 0,
              title: Text(volunteer.name),
              onTap: () => pushWidget(
                context: context,
                builder: (final context) => EditVolunteerScreen(
                  volunteerId: volunteer.id,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
