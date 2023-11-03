import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../database/database.dart';
import '../../extensions.dart';
import '../../providers/providers.dart';
import '../../screens/edit_subject_screen.dart';

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
            child: CallbackShortcuts(
              bindings: {
                renameShortcut: () => pushWidget(
                      context: context,
                      builder: (final context) => GetText(
                        onDone: (final value) async {
                          Navigator.pop(context);
                          final database = await ref.read(
                            databaseProvider.future,
                          );
                          await database.subjectsDao.editSubject(
                            subject: subject,
                            companion: SubjectsCompanion(name: Value(value)),
                          );
                          ref
                            ..invalidate(subjectsProvider)
                            ..invalidate(volunteerSubjectsProvider);
                        },
                        labelText: 'Name',
                        text: subject.name,
                        title: 'Subject Name',
                        tooltip: 'Save',
                        validator: notEmptyValidator,
                      ),
                    ),
              },
              child: CommonShortcuts(
                deleteCallback: () => confirm(
                  context: context,
                  message: 'Delete ${subject.name}?',
                  title: confirmDeleteTitle,
                  yesCallback: () async {
                    Navigator.pop(context);
                    final database = await ref.read(databaseProvider.future);
                    await database.subjectsDao.deleteSubject(subject);
                    ref.invalidate(subjectsProvider);
                  },
                ),
                child: ListTile(
                  autofocus: index == 0,
                  title: Text(subject.name),
                  onTap: () => pushWidget(
                    context: context,
                    builder: (final context) => EditSubjectScreen(
                      subjectId: subject.id,
                    ),
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
