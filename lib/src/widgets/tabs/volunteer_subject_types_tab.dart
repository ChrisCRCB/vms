import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/database.dart';
import '../../extensions.dart';
import '../../providers/providers.dart';

/// The volunteer subject types tab.
class VolunteerSubjectTypesTab extends ConsumerWidget {
  /// Create an instance.
  const VolunteerSubjectTypesTab({
    super.key,
  });

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final value = ref.watch(volunteerSubjectTypesProvider);
    return value.simpleWhen((final types) {
      if (types.isEmpty) {
        return const CenterText(
          text: 'No subject types to show.',
          autofocus: true,
        );
      }
      return BuiltSearchableListView(
        items: types,
        builder: (final context, final index) {
          final type = types[index];
          return SearchableListTile(
            searchString: type.name,
            child: CommonShortcuts(
              child: ListTile(
                autofocus: index == 0,
                title: Text(type.name),
                onTap: () => pushWidget(
                  context: context,
                  builder: (final context) => GetText(
                    onDone: (final value) async {
                      Navigator.pop(context);
                      final database = await ref.read(databaseProvider.future);
                      await database.volunteerSubjectTypesDao
                          .editVolunteerSubjectType(
                        volunteerSubjectType: type,
                        companion: VolunteerSubjectTypesCompanion(
                          name: Value(value),
                        ),
                      );
                      ref
                        ..invalidate(volunteerSubjectTypesProvider)
                        ..invalidate(
                          volunteerSubjectTypeProvider.call(type.id),
                        );
                    },
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
