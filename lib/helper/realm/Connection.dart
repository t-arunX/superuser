import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:superuser/helper/realm/source/person.dart';

import '../../widgets/LandingPage.dart';

class Connection {
  static Realm realm = Realm(Configuration.local(
      [Person.schema, Mobile.schema, Language.schema, Role.schema],
      schemaVersion: 5));

  insert(Person person) {
    return realm.write(() {
      realm.add<Person>(person);
    });
  }

  getUserList() {
    return Connection.realm.all<Person>();
  }

  updateUser(data, id) {
    Person obj = getUser(ObjectId.fromHexString(id));
    realm.write(() => {
          obj.username = data.username,
          obj.firstname = data.firstname,
          obj.lastname = data.lastname,
          obj.city = data.city,
          obj.state = data.state,
          obj.country = data.country,
          obj.imageUrl = data.imageUrl,

          //new changes
          obj.dob = data.dob,
          obj.mobile = Mobile(pin: data.mobile.pin, number: data.mobile.number),
          obj.gender = data.gender,
          obj.roles?.admin = data.roles.admin,
          obj.roles?.user = data.roles.user,
          // obj.roles = Role(admin: data.roles.admin ?? false, user: data.gender.user ?? false),
          obj.language?.name = data.language
          // obj.language = Language(name: data.language ?? "")
        });
  }

  updateImage(String image, id) {
    Person personObj = getUser(ObjectId.fromHexString(id));
    realm.write(() => {personObj.imageUrl = image});
  }

  deleteUser(personId) {
    // var person = getUser(id);
    realm.write(() => realm.delete<Person>(getUser(personId)));
  }

  getUser(id) {
    return realm.find<Person>(id);
  }

  deleteAll() {
    realm.write(() => realm.deleteAll<Person>());
  }
}

void main() {
  var con = Connection();
  // Connection.realm
  // con.deleteAll();

  // for (int i = 0; i < 30; i++) {
  //   con.insert(Person(ObjectId(), "Test$i",
  //       mobile: Mobile(pin: "IN", number: "789456123${i.toString()[0]}"),
  //       firstname: "first$i",
  //       lastname: "last$i",
  //       city: "city$i",
  //       state: "state$i",
  //       country: "country$i"));
  // }

  runApp(const LandingPage());
}
