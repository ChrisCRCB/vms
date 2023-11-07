import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A widget for launching [url].
class LaunchUrlWidget extends StatelessWidget {
  /// Create an instance.
  const LaunchUrlWidget({
    required this.url,
    required this.child,
    this.noUrlMessage = 'Cannot launch this URL.',
    super.key,
  });

  /// The URL to launch.
  final String? url;

  /// The message to show if [url] is `null`.
  final String noUrlMessage;

  /// The widget below this one in the tree.
  final Widget child;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => CommonShortcuts(
        child: child,
        testCallback: () async {
          final uri = url;
          if (uri == null) {
            return showMessage(
              context: context,
              message: noUrlMessage,
            );
          }
          return confirm(
            context: context,
            message: 'Launch $uri?',
            title: 'Launch URL',
            yesCallback: () {
              Navigator.pop(context);
              launchUrl(Uri.parse(uri));
            },
          );
        },
      );
}
