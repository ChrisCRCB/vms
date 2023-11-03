import 'package:backstreets_widgets/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recase/recase.dart';

import '../database/database.dart';
import '../providers/providers.dart';

/// A screen for selecting a new volunteer subject type.
class SelectVolunteerSubjectType extends ConsumerWidget {
  /// Create an instance.
  const SelectVolunteerSubjectType({
    required this.onChanged,
    required this.volunteerSubjectType,
    super.key,
  });

  /// The function to call with a new [volunteerSubjectType].
  final ValueChanged<VolunteerSubjectType> onChanged;

  /// THe current type.
  final VolunteerSubjectType volunteerSubjectType;

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final volunteerSubjectTypesValue = ref.watch(volunteerSubjectTypesProvider);
    return volunteerSubjectTypesValue.when(
      data: (final types) => SelectItem<VolunteerSubjectType>(
        values: types,
        onDone: onChanged,
        title: 'Select Subject Type',
        value: volunteerSubjectType,
        getSearchString: (final value) => value.name,
        getWidget: (final value) => Text(
          value.name.titleCase,
        ),
      ),
      error: ErrorScreen.withPositional,
      loading: LoadingScreen.new,
    );
  }
}
