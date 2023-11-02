import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../database/database.dart';
import '../../extensions.dart';
import '../../providers/providers.dart';

/// The tab to show groups.
class GroupsTab extends ConsumerWidget {
  /// Create an instance.
  const GroupsTab({
    super.key,
  });

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final value = ref.watch(groupsProvider);
    return value.simpleWhen((final data) {
      if (data.isEmpty) {
        return const CenterText(
          text: 'There are no groups to show.',
          autofocus: true,
        );
      }
      return BuiltSearchableListView(
        items: data,
        builder: (final context, final index) {
          final group = data[index];
          return SearchableListTile(
            searchString: group.name,
            child: CommonShortcuts(
              deleteCallback: () => confirm(
                context: context,
                message: 'Delete ${group.name}?',
                title: confirmDeleteTitle,
                yesCallback: () async {
                  Navigator.pop(context);
                  final database = await ref.read(databaseProvider.future);
                  await database.groupsDao.deleteGroup(group);
                  ref.invalidate(groupsProvider);
                },
              ),
              child: ListTile(
                autofocus: index == 0,
                title: Text(group.name),
                onTap: () => pushWidget(
                  context: context,
                  builder: (final context) => GetText(
                    onDone: (final value) async {
                      Navigator.pop(context);
                      final database = await ref.read(
                        databaseProvider.future,
                      );
                      await database.groupsDao.editGroup(
                        group: group,
                        companion: GroupsCompanion(name: Value(value)),
                      );
                      ref.invalidate(groupsProvider);
                    },
                    labelText: 'Name',
                    text: group.name,
                    title: 'Group Name',
                    tooltip: 'Save',
                    validator: notEmptyValidator,
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
