import '../database/database.dart';

/// A context which holds a [volunteer] and a [value].
class VolunteerContext<T> {
  /// Create an instance.
  const VolunteerContext({
    required this.volunteer,
    required this.value,
  });

  /// The volunteer to use.
  final Volunteer volunteer;

  /// The value to use.
  final T value;
}
