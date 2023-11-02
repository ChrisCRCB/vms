// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $VolunteersTable extends Volunteers
    with TableInfo<$VolunteersTable, Volunteer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VolunteersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailAddressMeta =
      const VerificationMeta('emailAddress');
  @override
  late final GeneratedColumn<String> emailAddress = GeneratedColumn<String>(
      'email_address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, phoneNumber, emailAddress];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'volunteers';
  @override
  VerificationContext validateIntegrity(Insertable<Volunteer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('email_address')) {
      context.handle(
          _emailAddressMeta,
          emailAddress.isAcceptableOrUnknown(
              data['email_address']!, _emailAddressMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Volunteer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Volunteer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number']),
      emailAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email_address']),
    );
  }

  @override
  $VolunteersTable createAlias(String alias) {
    return $VolunteersTable(attachedDatabase, alias);
  }
}

class Volunteer extends DataClass implements Insertable<Volunteer> {
  /// The primary key for this table.
  final int id;

  /// The name of something.
  final String name;

  /// The volunteer's phone number.
  final String? phoneNumber;

  /// The volunteer's email address.
  final String? emailAddress;
  const Volunteer(
      {required this.id,
      required this.name,
      this.phoneNumber,
      this.emailAddress});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || emailAddress != null) {
      map['email_address'] = Variable<String>(emailAddress);
    }
    return map;
  }

  VolunteersCompanion toCompanion(bool nullToAbsent) {
    return VolunteersCompanion(
      id: Value(id),
      name: Value(name),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      emailAddress: emailAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(emailAddress),
    );
  }

  factory Volunteer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Volunteer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      emailAddress: serializer.fromJson<String?>(json['emailAddress']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'emailAddress': serializer.toJson<String?>(emailAddress),
    };
  }

  Volunteer copyWith(
          {int? id,
          String? name,
          Value<String?> phoneNumber = const Value.absent(),
          Value<String?> emailAddress = const Value.absent()}) =>
      Volunteer(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
        emailAddress:
            emailAddress.present ? emailAddress.value : this.emailAddress,
      );
  @override
  String toString() {
    return (StringBuffer('Volunteer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('emailAddress: $emailAddress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phoneNumber, emailAddress);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Volunteer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phoneNumber == this.phoneNumber &&
          other.emailAddress == this.emailAddress);
}

class VolunteersCompanion extends UpdateCompanion<Volunteer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phoneNumber;
  final Value<String?> emailAddress;
  const VolunteersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.emailAddress = const Value.absent(),
  });
  VolunteersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phoneNumber = const Value.absent(),
    this.emailAddress = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Volunteer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phoneNumber,
    Expression<String>? emailAddress,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (emailAddress != null) 'email_address': emailAddress,
    });
  }

  VolunteersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? phoneNumber,
      Value<String?>? emailAddress}) {
    return VolunteersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (emailAddress.present) {
      map['email_address'] = Variable<String>(emailAddress.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VolunteersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('emailAddress: $emailAddress')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(Insertable<Subject> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  /// The primary key for this table.
  final int id;

  /// The name of something.
  final String name;
  const Subject({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Subject.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Subject copyWith({int? id, String? name}) => Subject(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject && other.id == this.id && other.name == this.name);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<String> name;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  SubjectsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Subject> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  SubjectsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return SubjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $VolunteerSubjectsTable extends VolunteerSubjects
    with TableInfo<$VolunteerSubjectsTable, VolunteerSubject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VolunteerSubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _volunteerIdMeta =
      const VerificationMeta('volunteerId');
  @override
  late final GeneratedColumn<int> volunteerId = GeneratedColumn<int>(
      'volunteer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES volunteers (id) ON DELETE CASCADE'));
  static const VerificationMeta _subjectIdMeta =
      const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
      'subject_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES subjects (id) ON DELETE CASCADE'));
  static const VerificationMeta _subjectTypeMeta =
      const VerificationMeta('subjectType');
  @override
  late final GeneratedColumnWithTypeConverter<VolunteerSubjectType, int>
      subjectType = GeneratedColumn<int>('subject_type', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: Constant(VolunteerSubjectType.skill.index))
          .withConverter<VolunteerSubjectType>(
              $VolunteerSubjectsTable.$convertersubjectType);
  @override
  List<GeneratedColumn> get $columns =>
      [id, volunteerId, subjectId, subjectType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'volunteer_subjects';
  @override
  VerificationContext validateIntegrity(Insertable<VolunteerSubject> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('volunteer_id')) {
      context.handle(
          _volunteerIdMeta,
          volunteerId.isAcceptableOrUnknown(
              data['volunteer_id']!, _volunteerIdMeta));
    } else if (isInserting) {
      context.missing(_volunteerIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    context.handle(_subjectTypeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VolunteerSubject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VolunteerSubject(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      volunteerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}volunteer_id'])!,
      subjectId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subject_id'])!,
      subjectType: $VolunteerSubjectsTable.$convertersubjectType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}subject_type'])!),
    );
  }

  @override
  $VolunteerSubjectsTable createAlias(String alias) {
    return $VolunteerSubjectsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<VolunteerSubjectType, int, int>
      $convertersubjectType = const EnumIndexConverter<VolunteerSubjectType>(
          VolunteerSubjectType.values);
}

class VolunteerSubject extends DataClass
    implements Insertable<VolunteerSubject> {
  /// The primary key for this table.
  final int id;

  /// The ID of the volunteer to use.
  final int volunteerId;

  /// The ID of the subject to link to the volunteer.
  final int subjectId;

  /// The type of the subject.
  final VolunteerSubjectType subjectType;
  const VolunteerSubject(
      {required this.id,
      required this.volunteerId,
      required this.subjectId,
      required this.subjectType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['volunteer_id'] = Variable<int>(volunteerId);
    map['subject_id'] = Variable<int>(subjectId);
    {
      final converter = $VolunteerSubjectsTable.$convertersubjectType;
      map['subject_type'] = Variable<int>(converter.toSql(subjectType));
    }
    return map;
  }

  VolunteerSubjectsCompanion toCompanion(bool nullToAbsent) {
    return VolunteerSubjectsCompanion(
      id: Value(id),
      volunteerId: Value(volunteerId),
      subjectId: Value(subjectId),
      subjectType: Value(subjectType),
    );
  }

  factory VolunteerSubject.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VolunteerSubject(
      id: serializer.fromJson<int>(json['id']),
      volunteerId: serializer.fromJson<int>(json['volunteerId']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      subjectType: $VolunteerSubjectsTable.$convertersubjectType
          .fromJson(serializer.fromJson<int>(json['subjectType'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'volunteerId': serializer.toJson<int>(volunteerId),
      'subjectId': serializer.toJson<int>(subjectId),
      'subjectType': serializer.toJson<int>(
          $VolunteerSubjectsTable.$convertersubjectType.toJson(subjectType)),
    };
  }

  VolunteerSubject copyWith(
          {int? id,
          int? volunteerId,
          int? subjectId,
          VolunteerSubjectType? subjectType}) =>
      VolunteerSubject(
        id: id ?? this.id,
        volunteerId: volunteerId ?? this.volunteerId,
        subjectId: subjectId ?? this.subjectId,
        subjectType: subjectType ?? this.subjectType,
      );
  @override
  String toString() {
    return (StringBuffer('VolunteerSubject(')
          ..write('id: $id, ')
          ..write('volunteerId: $volunteerId, ')
          ..write('subjectId: $subjectId, ')
          ..write('subjectType: $subjectType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, volunteerId, subjectId, subjectType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VolunteerSubject &&
          other.id == this.id &&
          other.volunteerId == this.volunteerId &&
          other.subjectId == this.subjectId &&
          other.subjectType == this.subjectType);
}

class VolunteerSubjectsCompanion extends UpdateCompanion<VolunteerSubject> {
  final Value<int> id;
  final Value<int> volunteerId;
  final Value<int> subjectId;
  final Value<VolunteerSubjectType> subjectType;
  const VolunteerSubjectsCompanion({
    this.id = const Value.absent(),
    this.volunteerId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.subjectType = const Value.absent(),
  });
  VolunteerSubjectsCompanion.insert({
    this.id = const Value.absent(),
    required int volunteerId,
    required int subjectId,
    this.subjectType = const Value.absent(),
  })  : volunteerId = Value(volunteerId),
        subjectId = Value(subjectId);
  static Insertable<VolunteerSubject> custom({
    Expression<int>? id,
    Expression<int>? volunteerId,
    Expression<int>? subjectId,
    Expression<int>? subjectType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (volunteerId != null) 'volunteer_id': volunteerId,
      if (subjectId != null) 'subject_id': subjectId,
      if (subjectType != null) 'subject_type': subjectType,
    });
  }

  VolunteerSubjectsCompanion copyWith(
      {Value<int>? id,
      Value<int>? volunteerId,
      Value<int>? subjectId,
      Value<VolunteerSubjectType>? subjectType}) {
    return VolunteerSubjectsCompanion(
      id: id ?? this.id,
      volunteerId: volunteerId ?? this.volunteerId,
      subjectId: subjectId ?? this.subjectId,
      subjectType: subjectType ?? this.subjectType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (volunteerId.present) {
      map['volunteer_id'] = Variable<int>(volunteerId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (subjectType.present) {
      final converter = $VolunteerSubjectsTable.$convertersubjectType;

      map['subject_type'] = Variable<int>(converter.toSql(subjectType.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VolunteerSubjectsCompanion(')
          ..write('id: $id, ')
          ..write('volunteerId: $volunteerId, ')
          ..write('subjectId: $subjectId, ')
          ..write('subjectType: $subjectType')
          ..write(')'))
        .toString();
  }
}

class $GroupsTable extends Groups with TableInfo<$GroupsTable, Group> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'groups';
  @override
  VerificationContext validateIntegrity(Insertable<Group> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Group map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Group(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $GroupsTable createAlias(String alias) {
    return $GroupsTable(attachedDatabase, alias);
  }
}

class Group extends DataClass implements Insertable<Group> {
  /// The primary key for this table.
  final int id;

  /// The name of something.
  final String name;
  const Group({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  GroupsCompanion toCompanion(bool nullToAbsent) {
    return GroupsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Group.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Group(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Group copyWith({int? id, String? name}) => Group(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Group(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Group && other.id == this.id && other.name == this.name);
}

class GroupsCompanion extends UpdateCompanion<Group> {
  final Value<int> id;
  final Value<String> name;
  const GroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  GroupsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Group> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  GroupsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return GroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $VolunteerGroupsTable extends VolunteerGroups
    with TableInfo<$VolunteerGroupsTable, VolunteerGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VolunteerGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _volunteerIdMeta =
      const VerificationMeta('volunteerId');
  @override
  late final GeneratedColumn<int> volunteerId = GeneratedColumn<int>(
      'volunteer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES volunteers (id) ON DELETE CASCADE'));
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
      'group_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES "groups" (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [id, volunteerId, groupId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'volunteer_groups';
  @override
  VerificationContext validateIntegrity(Insertable<VolunteerGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('volunteer_id')) {
      context.handle(
          _volunteerIdMeta,
          volunteerId.isAcceptableOrUnknown(
              data['volunteer_id']!, _volunteerIdMeta));
    } else if (isInserting) {
      context.missing(_volunteerIdMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VolunteerGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VolunteerGroup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      volunteerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}volunteer_id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id'])!,
    );
  }

  @override
  $VolunteerGroupsTable createAlias(String alias) {
    return $VolunteerGroupsTable(attachedDatabase, alias);
  }
}

class VolunteerGroup extends DataClass implements Insertable<VolunteerGroup> {
  /// The primary key for this table.
  final int id;

  /// The ID of the volunteer to use.
  final int volunteerId;

  /// The ID of the group to link to the volunteer.
  final int groupId;
  const VolunteerGroup(
      {required this.id, required this.volunteerId, required this.groupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['volunteer_id'] = Variable<int>(volunteerId);
    map['group_id'] = Variable<int>(groupId);
    return map;
  }

  VolunteerGroupsCompanion toCompanion(bool nullToAbsent) {
    return VolunteerGroupsCompanion(
      id: Value(id),
      volunteerId: Value(volunteerId),
      groupId: Value(groupId),
    );
  }

  factory VolunteerGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VolunteerGroup(
      id: serializer.fromJson<int>(json['id']),
      volunteerId: serializer.fromJson<int>(json['volunteerId']),
      groupId: serializer.fromJson<int>(json['groupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'volunteerId': serializer.toJson<int>(volunteerId),
      'groupId': serializer.toJson<int>(groupId),
    };
  }

  VolunteerGroup copyWith({int? id, int? volunteerId, int? groupId}) =>
      VolunteerGroup(
        id: id ?? this.id,
        volunteerId: volunteerId ?? this.volunteerId,
        groupId: groupId ?? this.groupId,
      );
  @override
  String toString() {
    return (StringBuffer('VolunteerGroup(')
          ..write('id: $id, ')
          ..write('volunteerId: $volunteerId, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, volunteerId, groupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VolunteerGroup &&
          other.id == this.id &&
          other.volunteerId == this.volunteerId &&
          other.groupId == this.groupId);
}

class VolunteerGroupsCompanion extends UpdateCompanion<VolunteerGroup> {
  final Value<int> id;
  final Value<int> volunteerId;
  final Value<int> groupId;
  const VolunteerGroupsCompanion({
    this.id = const Value.absent(),
    this.volunteerId = const Value.absent(),
    this.groupId = const Value.absent(),
  });
  VolunteerGroupsCompanion.insert({
    this.id = const Value.absent(),
    required int volunteerId,
    required int groupId,
  })  : volunteerId = Value(volunteerId),
        groupId = Value(groupId);
  static Insertable<VolunteerGroup> custom({
    Expression<int>? id,
    Expression<int>? volunteerId,
    Expression<int>? groupId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (volunteerId != null) 'volunteer_id': volunteerId,
      if (groupId != null) 'group_id': groupId,
    });
  }

  VolunteerGroupsCompanion copyWith(
      {Value<int>? id, Value<int>? volunteerId, Value<int>? groupId}) {
    return VolunteerGroupsCompanion(
      id: id ?? this.id,
      volunteerId: volunteerId ?? this.volunteerId,
      groupId: groupId ?? this.groupId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (volunteerId.present) {
      map['volunteer_id'] = Variable<int>(volunteerId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VolunteerGroupsCompanion(')
          ..write('id: $id, ')
          ..write('volunteerId: $volunteerId, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }
}

abstract class _$VolunteerDatabase extends GeneratedDatabase {
  _$VolunteerDatabase(QueryExecutor e) : super(e);
  late final $VolunteersTable volunteers = $VolunteersTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $VolunteerSubjectsTable volunteerSubjects =
      $VolunteerSubjectsTable(this);
  late final $GroupsTable groups = $GroupsTable(this);
  late final $VolunteerGroupsTable volunteerGroups =
      $VolunteerGroupsTable(this);
  late final VolunteersDao volunteersDao =
      VolunteersDao(this as VolunteerDatabase);
  late final SubjectsDao subjectsDao = SubjectsDao(this as VolunteerDatabase);
  late final VolunteerSubjectsDao volunteerSubjectsDao =
      VolunteerSubjectsDao(this as VolunteerDatabase);
  late final GroupsDao groupsDao = GroupsDao(this as VolunteerDatabase);
  late final VolunteerGroupsDao volunteerGroupsDao =
      VolunteerGroupsDao(this as VolunteerDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [volunteers, subjects, volunteerSubjects, groups, volunteerGroups];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('volunteers',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('volunteer_subjects', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('subjects',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('volunteer_subjects', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('volunteers',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('volunteer_groups', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('groups',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('volunteer_groups', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}
