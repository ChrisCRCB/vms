import '../database/database.dart';
import '../database/tables/volunteer_subjects.dart';
import 'volunteer_context.dart';

/// A class for holding details of a [VolunteerSubject].
class VolunteerSubjectContext extends VolunteerContext<Subject> {
  /// Create an instance.
  const VolunteerSubjectContext({
    required super.volunteer,
    required super.value,
    required this.type,
  });

  /// The type of subject.
  final VolunteerSubjectType type;
}
