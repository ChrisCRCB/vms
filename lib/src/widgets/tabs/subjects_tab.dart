import 'package:backstreets_widgets/widgets/center_text.dart';
import 'package:backstreets_widgets/widgets/searchable_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions.dart';
import '../../providers/providers.dart';

/// The subjects tab.
class SubjectsTab extends ConsumerWidget {
  /// Create an instance.
  const SubjectsTab({
    super.key,
  });

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final value = ref.watch(subjectsProvider);
    return value.simpleWhen((final data) {
      if (data.isEmpty) {
        return const CenterText(
          text: 'No subjects to show.',
          autofocus: true,
        );
      }
      return BuiltSearchableListView(
        items: data,
        builder: (final context, final index) {
          final subject = data[index];
          return SearchableListTile(
            searchString: subject.name,
            child: ListTile(
              autofocus: index == 0,
              title: Text(subject.name),
              onTap: () {},
            ),
          );
        },
      );
    });
  }
}
