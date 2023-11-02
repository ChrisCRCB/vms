import 'package:backstreets_widgets/widgets/center_text.dart';
import 'package:backstreets_widgets/widgets/searchable_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            child: ListTile(
              autofocus: index == 0,
              title: Text(group.name),
              onTap: () {},
            ),
          );
        },
      );
    });
  }
}
