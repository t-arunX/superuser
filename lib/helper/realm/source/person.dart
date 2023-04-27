import 'package:realm/realm.dart';

part 'person.g.dart';

@RealmModel()
class _Person{

  @PrimaryKey()
  late ObjectId userId;
  late String? imageUrl;
  late String username;
  late String? firstname;
  late String? lastname;
  late String? city;
  late String? state;
  late String? country;

  late String? dob;
  late String? gender;
  late _Mobile? mobile;
  late _Role? roles;
  late _Language? language;
}

@RealmModel()
class _Mobile{
  late String? pin;
  late String? number;
}

@RealmModel()
class _Role{
  late bool user;
  late bool admin;
}

@RealmModel()
class _Language{
  late List<String> name;
  late String? other;
}