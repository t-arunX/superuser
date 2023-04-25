import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realm/realm.dart';
import 'package:superuser/helper/realm/Connection.dart';

import '../../helper/realm/source/person.dart';
import '../HomePage.dart';

class CreateForm extends StatefulWidget {
  final Function setStateCallBack;

  const CreateForm(this.setStateCallBack, {Key? key}) : super(key: key);

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  final _crateFormKey = GlobalKey<FormState>();
  var usernameHandler = TextEditingController();
  var firstnameHandler = TextEditingController();
  var lastnameHandler = TextEditingController();
  var cityHandler = TextEditingController();
  var stateHandler = TextEditingController();
  var countryHandler = TextEditingController();

  String imagePlaceHolder = "assets/loading/profile_placeholder.jpg";

  List? handlers;

  Person data = Person(ObjectId(), "");

  String generateRandomString({int len = 9}) {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  setHandlers() {
    handlers = [
      usernameHandler,
      firstnameHandler,
      lastnameHandler,
      cityHandler,
      stateHandler,
      countryHandler
    ];
  }
  String? imgPath;

  _imageHandler(choice) {
    void imagePicker(choice) async {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? image;
        if (choice) {
          image = await picker.pickImage(source: ImageSource.gallery);
        } else {
          image = await picker.pickImage(source: ImageSource.camera);
        }
        setState(() {
          imgPath = image!.path;
          data.imageUrl = imgPath;
        });
        if (kDebugMode) {
          print(imgPath);
        }
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("something went wrong, please try again later")));
      }
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Row(children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          imagePicker(true);
                        },
                        child: const Icon(Icons.image)),
                    const Text("pick from gallery")
                  ],
                ),
                const Spacer(
                  flex: 1, // <-- SEE HERE
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          imagePicker(false);
                        },
                        child: const Icon(Icons.camera_alt_sharp)),
                    const Text("open camera")
                  ],
                ),
              ]),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    setHandlers();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _crateFormKey,
      child: ClipRect(
        child: Container(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "new form: ",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w100,
                    color: Colors.purple,
                  ),
                ),
              ),
              Badge(
                backgroundColor: Colors.transparent,
                alignment: const AlignmentDirectional(190, 110),
                largeSize: 90,
                label: ElevatedButton(
                    onPressed: () {
                      _imageHandler(true);
                    },
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(OutlinedBorder.lerp(
                            const CircleBorder(),
                            const CircleBorder(),
                            Checkbox.width)),
                        elevation: const MaterialStatePropertyAll(5),
                        shadowColor:
                            const MaterialStatePropertyAll(Colors.green)),
                    child: const Icon(Icons.edit)),
                child: SizedBox(
                  width: double.infinity,
                  child: CircleAvatar(
                    foregroundImage: FileImage(File(imgPath ?? imagePlaceHolder)),
                    backgroundImage: const AssetImage(
                        "assets/loading/profile_placeholder.jpg"),
                    backgroundColor: Colors.transparent,
                    radius: 100,
                    // child: Image.file(File(img??"")),
                  ),
                ),
              ),
              const SizedBox(),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'username',
                      errorStyle: TextStyle(color: Colors.red)),
                  validator: (value) {
                    return value == '' || value!.contains("@")
                        ? "text field can't be empty"
                        : null;
                  },
                  onSaved: (val) {
                    data.username = val!;
                  },
                  controller: usernameHandler,
                  autofillHints: const ["username", "password"],
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'firstname',
                    errorStyle: TextStyle(color: Colors.red)),
                validator: (value) {
                  return value == '' || value!.contains("@")
                      ? "text field can't be empty"
                      : null;
                },
                onSaved: (val) {
                  data.firstname = val;
                },
                controller: firstnameHandler,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'lastname',
                    errorStyle: TextStyle(color: Colors.red)),
                validator: (value) {
                  return value == '' || value!.contains("@")
                      ? "text field can't be empty"
                      : null;
                },
                onSaved: (val) {
                  data.lastname = val;
                },
                controller: lastnameHandler,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'city', errorStyle: TextStyle(color: Colors.red)),
                validator: (value) {
                  return value == '' || value!.contains("@")
                      ? "text field can't be empty"
                      : null;
                },
                onSaved: (val) {
                  data.city = val;
                },
                controller: cityHandler,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'state',
                    errorStyle: TextStyle(color: Colors.red)),
                validator: (value) {
                  return value == '' || value!.contains("@")
                      ? "text field can't be empty"
                      : null;
                },
                onSaved: (val) {
                  data.state = val;
                },
                controller: stateHandler,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'country',
                    errorStyle: TextStyle(color: Colors.red)),
                validator: (value) {
                  return value == '' || value!.contains("@")
                      ? "text field can't be empty"
                      : null;
                },
                onSaved: (val) {
                  data.country = val;
                },
                controller: countryHandler,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("cancel")),
                  // const SizedBox(width: 150,),
                  const Spacer(
                    flex: 1, // <-- SEE HERE
                  ),
                  ElevatedButton(
                      onPressed:  () {
                        if (_crateFormKey.currentState?.validate() ?? false) {
                          _crateFormKey.currentState?.save();
                          try {
                            Connection().insert(data);
                            widget.setStateCallBack();
                          } catch (ex) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("something went wrong, please try again later")));
                          }
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("create")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
