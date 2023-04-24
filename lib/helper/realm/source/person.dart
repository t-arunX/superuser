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

}
