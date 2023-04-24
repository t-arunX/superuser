import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:superuser/helper/realm/source/person.dart';
import 'package:superuser/widgets/LandingPage.dart';

class Connection {
  static Realm realm =
      Realm(Configuration.local([Person.schema], schemaVersion: 1));

  getMaxId() {
    var y = realm.all<Person>().query('Person.@max.UserId');
    return y;
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
      obj.imageUrl = data.imageUrl
    });
  }

  updateImage(Person data, Person obj) {
    realm.write(() => {
      obj.imageUrl = data.imageUrl
    });
  }

  deleteUser(person){
    // var person = getUser(id);
    realm.write(() =>
        realm.delete<Person>(person)
    );
  }

  getUser(id) {
    return realm.find<Person>(id);
  }
}

// void main() {
//   var con = Connection();
//   // print(con.getMaxId());print(con.getMaxId()con.insert(Person(ObjectId(),username: "tarun"))));
//   // print(["tarun","sai","sandeep"].map((i)=>con.insert(Person(ObjectId(), i))));
//   // var data = Connection.realm.all<Person>().query(r'username == $0',['tarun kumar']);
//   // print(data);
//   // data.single.username = 'tarun kumar';
//   // Connection.realm.write(() => {
//   // // data.first.username = "tarun kumar",
//   //   for(var i in data){
//   //     i.username = 'tarun kumar'
//   //   }
//   // });
//
//   // var data2 = Connection.realm.all<Person>().query(r'username == $0',['tarun']);
//   // print(data)
//   // var person = Connection().getUserList().first;
//   // var person2 = Connection().getUserList().last;
//   // person.username = "harimowa";
//
//   // Connection().updateUser(person);
//
//   // Connection.realm.write(() => {
//   //   // Connection.realm.deleteAll<Person>()
//   //   // Connection.realm.addAll<Person>([Person(ObjectId(),"Tarun",firstname: "tarun",lastname: "kumar",country: "india",city: "vizag",state: "AP",imageUrl: "https://static.wikia.nocookie.net/kimetsu-no-yaiba/images/f/f9/Tanjiro_Anime_Profile.png/revision/latest/scale-to-width-down/98?cb=20191224040903")])
//   //   // Connection.realm.add<Person>(person,update: true)
//   //   // person2.username = person.username
//   // // person.username = "harimowa"
//   // });
//
//
//   // var person = Connection().getUserList();
//   // print(person);
// // Connection().deleteUser(person);
// //   var person2 = Connection().getUserList().first;
//   // print(person2);
//
//   runApp(const LandingPage());
// }
