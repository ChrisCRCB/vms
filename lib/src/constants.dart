import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
