class PersonModel {
  late String userId;
  late String? imageUrl;
  late String? username;
  late String? firstname;
  late String? lastname;
  late String? city;
  late String? state;
  late String? country;

  late String? dob;
  late String? gender;
  late MobileM? mobile;
  late RoleM? roles;
  late LanguageM? language;

  PersonModel(
      {required this.userId,
      this.imageUrl,
      this.username,
      this.firstname,
      this.lastname,
      this.city,
      this.state,
      this.country,
      this.dob,
      this.gender,
      this.mobile,
      this.roles,
      this.language});
}

class MobileM {
  late String? pin;
  late String? number;

  MobileM({this.pin, this.number});
}

class RoleM {
  late bool? user;
  late bool? admin;

  RoleM({this.user, this.admin});
}

class LanguageM {
  late List<String>? name;

  LanguageM({this.name});
}
