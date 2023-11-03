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
import 'select_volunteer_subject_type.dart';

/// Edit a particular subject.
class EditSubjectScreen extends ConsumerStatefulWidget {
  /// Create an instance.
  const EditSubjectScreen({
    required this.subjectId,
    super.key,
  });

  /// The ID of the subject to edit.
  final int subjectId;

  /// Create state for this widget.
  @override
  EditSubjectScreenState createState() => EditSubjectScreenState();
}

/// State for [EditSubjectScreen].
class EditSubjectScreenState extends ConsumerState<EditSubjectScreen> {
  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final value = ref.watch(subjectProvider.call(widget.subjectId));
    return Cancel(
      child: value.when(
        data: (final subject) => TabbedScaffold(
          tabs: [
            TabbedScaffoldTab(
              title: 'Details',
              icon: detailsIcon,
              builder: (final context) => ListView(
                children: [
                  TextListTile(
                    value: subject.name,
                    onChanged: (final value) async {
                      final database = await ref.read(databaseProvider.future);
                      await database.subjectsDao.editSubject(
                        subject: subject,
                        companion: SubjectsCompanion(name: Value(value)),
                      );
                      ref
                        ..invalidate(subjectsProvider)
                        ..invalidate(subjectProvider.call(subject.id))
                        ..invalidate(
                          volunteersWithSubjectProvider.call(subject),
                        );
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
              icon: Text('Volunteers with the ${subject.name} subject'),
              builder: (final context) {
                final volunteersValue = ref.watch(
                  volunteersWithSubjectProvider.call(
                    subject,
                  ),
                );
                return CommonShortcuts(
                  newCallback: addVolunteerToSubject,
                  child: volunteersValue.simpleWhen((final volunteers) {
                    if (volunteers.isEmpty) {
                      return CenterText(
                        text:
                            'There are no volunteers with the ${subject.name} '
                            'subject.',
                        autofocus: true,
                      );
                    }
                    return BuiltSearchableListView(
                      items: volunteers,
                      builder: (final context, final index) {
                        final volunteerSubjectContext = volunteers[index];
                        final volunteer = volunteerSubjectContext.volunteer;
                        final type = volunteerSubjectContext.type ??
                            unsetVolunteerSubjectType;
                        return SearchableListTile(
                          searchString: volunteer.name,
                          child: CommonShortcuts(
                            deleteCallback: () async {
                              final database =
                                  await ref.read(databaseProvider.future);
                              await database.volunteerSubjectsDao
                                  .deleteVolunteerSubject(
                                volunteerSubjectContext.volunteerSubject,
                              );
                              ref
                                ..invalidate(
                                  volunteersWithSubjectProvider.call(subject),
                                )
                                ..invalidate(
                                  volunteerSubjectsProvider.call(volunteer),
                                );
                            },
                            child: ListTile(
                              autofocus: index == 0,
                              title: Text(volunteer.name),
                              subtitle: Text(type.name),
                              onTap: () => pushWidget(
                                context: context,
                                builder: (final context) =>
                                    SelectVolunteerSubjectType(
                                  onChanged: (final value) async {
                                    final database = await ref.read(
                                      databaseProvider.future,
                                    );
                                    await database.volunteerSubjectsDao
                                        .editVolunteerSubject(
                                      volunteerSubject: volunteerSubjectContext
                                          .volunteerSubject,
                                      companion: VolunteerSubjectsCompanion(
                                        subjectTypeId: Value(value.id),
                                      ),
                                    );
                                    ref
                                      ..invalidate(
                                        volunteerSubjectsProvider.call(
                                          volunteer,
                                        ),
                                      )
                                      ..invalidate(
                                        volunteersWithSubjectProvider.call(
                                          subject,
                                        ),
                                      );
                                  },
                                  volunteerSubjectType: type,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                );
              },
              floatingActionButton: NewButton(
                onPressed: addVolunteerToSubject,
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

  /// Add a new volunteer to the subject.
  Future<void> addVolunteerToSubject() async {
    final subject = await ref.read(
      subjectProvider.call(widget.subjectId).future,
    );
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
                await database.volunteerSubjectsDao.createVolunteerSubject(
                  volunteer: volunteer,
                  subject: subject,
                );
                ref
                  ..invalidate(subjectProvider.call(subject.id))
                  ..invalidate(
                    volunteersWithSubjectProvider.call(subject),
                  )
                  ..invalidate(volunteerSubjectsProvider.call(volunteer));
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
