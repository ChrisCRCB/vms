import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'database/database.dart';

/// The message to show when something is unset.
const unsetMessage = 'Not set';

/// The title for deleting.
const confirmDeleteTitle = 'Confirm Delete';

/// The not empty validator.
String? notEmptyValidator(final String? value) {
  if (value == null || value.isEmpty) {
    return 'Value must not be empty.';
  }
  return null;
}

/// The rename keyboard shortcut.
const renameShortcut = SingleActivator(LogicalKeyboardKey.f2);

/// The details icon to use.
const detailsIcon = Icon(
  Icons.details_rounded,
  semanticLabel: 'Details',
);

/// The unset volunteer subject type.
const unsetVolunteerSubjectType = VolunteerSubjectType(
  id: -1,
  name: unsetMessage,
);
