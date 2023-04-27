import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:superuser/helper/realm/source/person.dart';

import '../../widgets/LandingPage.dart';

class Connection {
  static Realm realm = Realm(Configuration.local(
      [Person.schema, Mobile.schema, Language.schema, Role.schema],
      schemaVersion: 5));

  getMaxId() {
    // var y = realm.all<Person>().query('Person.@max.UserId');
    // return y;
  }

  insert(Person person) {
    // Person persons = person;
    return realm.write(() {
      realm.add<Person>(person);
    });
  }

  getUserList() {
    return Connection.realm.all<Person>();
  }

  updateUser(Person data, Person obj) {
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
          obj.mobile = data.mobile,
          obj.gender = data.gender,
          obj.roles = data.roles,
          obj.language = data.language
        });
  }

  updateImage(Person data, Person obj) {
    realm.write(() => {obj.imageUrl = data.imageUrl});
  }

  deleteUser(person) {
    // var person = getUser(id);
    realm.write(() => realm.delete<Person>(person));
  }

  getUser(id) {
    return realm.find<Person>(id);
  }
}

void main() {
  var con = Connection();
  // Connection.realm

  var res = con.getUserList();
  // print(res[0].mobile?.pin);

  runApp(const LandingPage());
}
