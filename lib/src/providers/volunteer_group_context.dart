import '../database/database.dart';

/// A class which represents a [VolunteerGroup].
class VolunteerGroupContext {
  /// Create an instance.
  const VolunteerGroupContext({
    required this.volunteer,
    required this.volunteerGroup,
    required this.group,
  });

  /// The volunteer to use.
  final Volunteer volunteer;

  /// The volunteer group to use.
  final VolunteerGroup volunteerGroup;

  /// The group which [volunteer] is linked to.
  final Group group;
}
