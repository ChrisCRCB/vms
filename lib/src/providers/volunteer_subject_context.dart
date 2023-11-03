import '../database/database.dart';

/// A class for holding details of a [VolunteerSubject].
class VolunteerSubjectContext {
  /// Create an instance.
  const VolunteerSubjectContext({
    required this.volunteer,
    required this.volunteerSubject,
    required this.subject,
    required this.type,
  });

  /// The volunteer to use.
  final Volunteer volunteer;

  /// The volunteer subject to use.
  final VolunteerSubject volunteerSubject;

  /// The subject that is linked to [volunteer].
  final Subject subject;

  /// The type of subject.
  final VolunteerSubjectType? type;
}
