import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Add useful methods.
extension VolunteerAsyncValueMethods<T> on AsyncValue<T> {
  /// A simpler version of [when].
  Widget simpleWhen(final Widget Function(T data) data) => when(
        data: data,
        error: ErrorListView.withPositional,
        loading: LoadingWidget.new,
      );
}
