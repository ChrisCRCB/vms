import 'package:flutter/material.dart';

/// A suitable button.
class NewButton extends StatelessWidget {
  /// Create an instance.
  const NewButton({
    required this.onPressed,
    this.tooltip = 'New',
    super.key,
  });

  /// The function to call when this button is pressed.
  final VoidCallback onPressed;

  /// The tooltip for this button.
  final String tooltip;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => FloatingActionButton(
        onPressed: onPressed,
        tooltip: tooltip,
        child: Icon(
          Icons.add,
          semanticLabel: tooltip,
        ),
      );
}
