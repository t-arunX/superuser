// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Person extends _Person with RealmEntity, RealmObjectBase, RealmObject {
  Person(
    ObjectId userId,
    String username, {
    String? imageUrl,
    String? firstname,
    String? lastname,
    String? city,
    String? state,
    String? country,
    String? dob,
    String? gender,
    Mobile? mobile,
    Role? roles,
    Language? language,
  }) {
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'imageUrl', imageUrl);
    RealmObjectBase.set(this, 'username', username);
    RealmObjectBase.set(this, 'firstname', firstname);
    RealmObjectBase.set(this, 'lastname', lastname);
    RealmObjectBase.set(this, 'city', city);
    RealmObjectBase.set(this, 'state', state);
    RealmObjectBase.set(this, 'country', country);
    RealmObjectBase.set(this, 'dob', dob);
    RealmObjectBase.set(this, 'gender', gender);
    RealmObjectBase.set(this, 'mobile', mobile);
    RealmObjectBase.set(this, 'roles', roles);
    RealmObjectBase.set(this, 'language', language);
  }

  Person._();

  @override
  ObjectId get userId =>
      RealmObjectBase.get<ObjectId>(this, 'userId') as ObjectId;
  @override
  set userId(ObjectId value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get imageUrl =>
      RealmObjectBase.get<String>(this, 'imageUrl') as String?;
  @override
  set imageUrl(String? value) => RealmObjectBase.set(this, 'imageUrl', value);

  @override
  String get username =>
      RealmObjectBase.get<String>(this, 'username') as String;
  @override
  set username(String value) => RealmObjectBase.set(this, 'username', value);

  @override
  String? get firstname =>
      RealmObjectBase.get<String>(this, 'firstname') as String?;
  @override
  set firstname(String? value) => RealmObjectBase.set(this, 'firstname', value);

  @override
  String? get lastname =>
      RealmObjectBase.get<String>(this, 'lastname') as String?;
  @override
  set lastname(String? value) => RealmObjectBase.set(this, 'lastname', value);

  @override
  String? get city => RealmObjectBase.get<String>(this, 'city') as String?;
  @override
  set city(String? value) => RealmObjectBase.set(this, 'city', value);

  @override
  String? get state => RealmObjectBase.get<String>(this, 'state') as String?;
  @override
  set state(String? value) => RealmObjectBase.set(this, 'state', value);

  @override
  String? get country =>
      RealmObjectBase.get<String>(this, 'country') as String?;
  @override
  set country(String? value) => RealmObjectBase.set(this, 'country', value);

  @override
  String? get dob => RealmObjectBase.get<String>(this, 'dob') as String?;
  @override
  set dob(String? value) => RealmObjectBase.set(this, 'dob', value);

  @override
  String? get gender => RealmObjectBase.get<String>(this, 'gender') as String?;
  @override
  set gender(String? value) => RealmObjectBase.set(this, 'gender', value);

  @override
  Mobile? get mobile => RealmObjectBase.get<Mobile>(this, 'mobile') as Mobile?;
  @override
  set mobile(covariant Mobile? value) =>
      RealmObjectBase.set(this, 'mobile', value);

  @override
  Role? get roles => RealmObjectBase.get<Role>(this, 'roles') as Role?;
  @override
  set roles(covariant Role? value) => RealmObjectBase.set(this, 'roles', value);

  @override
  Language? get language =>
      RealmObjectBase.get<Language>(this, 'language') as Language?;
  @override
  set language(covariant Language? value) =>
      RealmObjectBase.set(this, 'language', value);

  @override
  Stream<RealmObjectChanges<Person>> get changes =>
      RealmObjectBase.getChanges<Person>(this);

  @override
  Person freeze() => RealmObjectBase.freezeObject<Person>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Person._);
    return const SchemaObject(ObjectType.realmObject, Person, 'Person', [
      SchemaProperty('userId', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('imageUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('username', RealmPropertyType.string),
      SchemaProperty('firstname', RealmPropertyType.string, optional: true),
      SchemaProperty('lastname', RealmPropertyType.string, optional: true),
      SchemaProperty('city', RealmPropertyType.string, optional: true),
      SchemaProperty('state', RealmPropertyType.string, optional: true),
      SchemaProperty('country', RealmPropertyType.string, optional: true),
      SchemaProperty('dob', RealmPropertyType.string, optional: true),
      SchemaProperty('gender', RealmPropertyType.string, optional: true),
      SchemaProperty('mobile', RealmPropertyType.object,
          optional: true, linkTarget: 'Mobile'),
      SchemaProperty('roles', RealmPropertyType.object,
          optional: true, linkTarget: 'Role'),
      SchemaProperty('language', RealmPropertyType.object,
          optional: true, linkTarget: 'Language'),
    ]);
  }
}

class Mobile extends _Mobile with RealmEntity, RealmObjectBase, RealmObject {
  Mobile({
    String? pin,
    String? number,
  }) {
    RealmObjectBase.set(this, 'pin', pin);
    RealmObjectBase.set(this, 'number', number);
  }

  Mobile._();

  @override
  String? get pin => RealmObjectBase.get<String>(this, 'pin') as String?;
  @override
  set pin(String? value) => RealmObjectBase.set(this, 'pin', value);

  @override
  String? get number => RealmObjectBase.get<String>(this, 'number') as String?;
  @override
  set number(String? value) => RealmObjectBase.set(this, 'number', value);

  @override
  Stream<RealmObjectChanges<Mobile>> get changes =>
      RealmObjectBase.getChanges<Mobile>(this);

  @override
  Mobile freeze() => RealmObjectBase.freezeObject<Mobile>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Mobile._);
    return const SchemaObject(ObjectType.realmObject, Mobile, 'Mobile', [
      SchemaProperty('pin', RealmPropertyType.string, optional: true),
      SchemaProperty('number', RealmPropertyType.string, optional: true),
    ]);
  }
}

class Role extends _Role with RealmEntity, RealmObjectBase, RealmObject {
  Role(
    bool user,
    bool admin,
  ) {
    RealmObjectBase.set(this, 'user', user);
    RealmObjectBase.set(this, 'admin', admin);
  }

  Role._();

  @override
  bool get user => RealmObjectBase.get<bool>(this, 'user') as bool;
  @override
  set user(bool value) => RealmObjectBase.set(this, 'user', value);

  @override
  bool get admin => RealmObjectBase.get<bool>(this, 'admin') as bool;
  @override
  set admin(bool value) => RealmObjectBase.set(this, 'admin', value);

  @override
  Stream<RealmObjectChanges<Role>> get changes =>
      RealmObjectBase.getChanges<Role>(this);

  @override
  Role freeze() => RealmObjectBase.freezeObject<Role>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Role._);
    return const SchemaObject(ObjectType.realmObject, Role, 'Role', [
      SchemaProperty('user', RealmPropertyType.bool),
      SchemaProperty('admin', RealmPropertyType.bool),
    ]);
  }
}

class Language extends _Language
    with RealmEntity, RealmObjectBase, RealmObject {
  Language({
    String? other,
    Iterable<String> name = const [],
  }) {
    RealmObjectBase.set(this, 'other', other);
    RealmObjectBase.set<RealmList<String>>(
        this, 'name', RealmList<String>(name));
  }

  Language._();

  @override
  RealmList<String> get name =>
      RealmObjectBase.get<String>(this, 'name') as RealmList<String>;
  @override
  set name(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get other => RealmObjectBase.get<String>(this, 'other') as String?;
  @override
  set other(String? value) => RealmObjectBase.set(this, 'other', value);

  @override
  Stream<RealmObjectChanges<Language>> get changes =>
      RealmObjectBase.getChanges<Language>(this);

  @override
  Language freeze() => RealmObjectBase.freezeObject<Language>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Language._);
    return const SchemaObject(ObjectType.realmObject, Language, 'Language', [
      SchemaProperty('name', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('other', RealmPropertyType.string, optional: true),
    ]);
  }
}
