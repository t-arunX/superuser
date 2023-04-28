import 'package:flutter/material.dart';

import '../helper/realm/Connection.dart';
import '../helper/realm/source/person.dart';
import '../model/PersonModel.dart';
import 'components/Tile.dart';
import 'components/createForm.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<PersonModel> usersList;
  late Widget data;

  toModel() {
    List<PersonModel> personModels = [];
    for (Person person in Connection().getUserList()) {
      personModels.add(PersonModel(
          username: person.username,
          firstname: person.firstname,
          lastname: person.lastname,
          city: person.city,
          state: person.state,
          country: person.country,
          imageUrl: person.imageUrl,
          dob: person.dob,
          roles: RoleM(user: person.roles?.user, admin: person.roles?.admin),
          mobile:
              MobileM(pin: person.mobile?.pin, number: person.mobile?.number),
          gender: person.gender,
          language: LanguageM(name: person.language?.name),
          userId: person.userId.toString()));
    }
    return personModels;
  }

  getWidget(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Tile(data[index], index, fetch);
      },
    );
  }

  fetch({index}) {
    if (index >= 0) {
      //print(usersList.elementAt(index).username);
      // data = Container();
      setState(() {
        //   data = getWidget(usersList);
        usersList.removeAt(index);
      });
    } else {
      setState(() {
        // data = getWidget(toModel());
        usersList = toModel();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      usersList = toModel();
      //data = getWidget(usersList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          "Super admin",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1),
        child: ListView.builder(
          itemCount: usersList.length,
          itemBuilder: (BuildContext context, int index) {
            return Tile(usersList[index], index, fetch);
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: const ButtonStyle(
            elevation: MaterialStatePropertyAll(8),
            shadowColor: MaterialStatePropertyAll(Colors.deepPurple)),
        child: const Icon(Icons.add),
        onPressed: () {
          _showDialogBox(context, fetch);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _showDialogBox(context, void Function() initState) {
    return showDialog(
        useSafeArea: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CreateForm(initState),
              ),
            ),
          );
        });
  }
}
