import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/database.dart';
import '../../extensions.dart';
import '../../providers/providers.dart';
import 'volunteers_tab.dart';

/// A tab to show volunteers in a [group].
class VolunteersInGroupTab extends ConsumerWidget {
  /// Create an instance.
  const VolunteersInGroupTab({
    required this.group,
    super.key,
  });

  /// The group to use.
  final Group group;

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final value = ref.watch(volunteersInGroupProvider.call(group));
    return value.simpleWhen(
      (final volunteers) => VolunteersTab(
        volunteers: volunteers,
      ),
    );
  }
}
