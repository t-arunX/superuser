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
  }) {
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'imageUrl', imageUrl);
    RealmObjectBase.set(this, 'username', username);
    RealmObjectBase.set(this, 'firstname', firstname);
    RealmObjectBase.set(this, 'lastname', lastname);
    RealmObjectBase.set(this, 'city', city);
    RealmObjectBase.set(this, 'state', state);
    RealmObjectBase.set(this, 'country', country);
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
    ]);
  }

  @override
  String toString() {
    return 'userID: $userId,userId: $username';
  }
}
