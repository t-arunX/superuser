import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:realm/realm.dart';
import 'package:superuser/helper/realm/Connection.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../helper/realm/source/person.dart';

enum Gender { male, female, other, none }
//
// enum Roles { user, admin , superAdmin}

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
  var otherLangController = TextEditingController();

  String imagePlaceHolder = "assets/loading/profile_placeholder.jpg";

  List? handlers;

  String? imgPath;

  Person data = Person(ObjectId(), "");

  Gender _gender = Gender.none;

  List _roles = [false, false];

  List _langs = [false, false, false, false];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "new form: ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                    color: Colors.indigo,
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
                    foregroundImage:
                        FileImage(File(imgPath ?? imagePlaceHolder)),
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
                      helperText: "required*",
                      helperStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
              Container(
                width: 300,
                // height: 80,
                child: IntlPhoneField(
                  decoration: const InputDecoration(
                    helperText: "required*",
                    helperStyle: TextStyle(color: Colors.red),
                    labelText: 'Phone Number *',
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    // ),
                  ),
                  initialCountryCode: 'IN',
                  onSaved: (val) {
                    data.mobile =
                        Mobile(pin: val?.countryISOCode, number: val?.number);
                  },
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    helperText: "required*",
                    helperStyle: TextStyle(color: Colors.red),
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
                    helperText: "required*",
                    helperStyle: TextStyle(color: Colors.red),
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
              ExpansionTile(
                leading: const Icon(Icons.calendar_month_sharp),
                // onExpansionChanged: (state) => _isCalenderExpanded = state,
                title: const Text("Date of birth"),
                children: [
                  SfDateRangePicker(
                    onSelectionChanged: (val) {
                      // print(val.value.toString().split(" ")[0]);
                      data.dob = val.value.toString().split(' ').first;
                    },
                  ),
                ],
              ),
              ExpansionTile(
                // onExpansionChanged: (state) => _isCalenderExpanded = state,
                title: const Text("Gender"),
                children: [
                  ListTile(
                    title: const Text('None'),
                    contentPadding: const EdgeInsets.all(0),
                    leading: Radio<Gender>(
                      value: Gender.none,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Male'),
                    contentPadding: const EdgeInsets.all(0),
                    leading: Radio<Gender>(
                      value: Gender.male,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Female'),
                    contentPadding: const EdgeInsets.all(0),
                    leading: Radio<Gender>(
                      value: Gender.female,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Other'),
                    subtitle: const Text(
                      "Tap to choose",
                      style: TextStyle(fontSize: 14),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    leading: Radio<Gender>(
                      value: Gender.other,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(
                    helperText: "required*",
                    helperStyle: TextStyle(color: Colors.red),
                    hintText: 'city',
                    errorStyle: TextStyle(color: Colors.red)),
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
                    helperText: "required*",
                    helperStyle: TextStyle(color: Colors.red),
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
                    helperText: "required*",
                    helperStyle: TextStyle(color: Colors.red),
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
              // checks

              // mobile number with country suggestion(icons with country pins)
              // gender [male female, other]
              // Container(
              //     padding: const EdgeInsets.all(5),
              //     margin: const EdgeInsets.only(right: 220),
              //     child: const Text(
              //       "Gender: ",
              //       style: TextStyle(
              //           color: Colors.grey, fontWeight: FontWeight.bold),
              //     )),

              // const Divider(),
              // access role [user,admin,{join account access}]
              Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(right: 220),
                  child: const Text(
                    "Roles: ",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: const EdgeInsets.only(right: 150),
                  width: 200,
                  child: Column(
                    children: [
                      CheckboxListTile(
                        value: _roles[0],
                        onChanged: (val) => setState(() {
                          _roles[0] = val;
                        }),
                        title: const Text("user"),
                      ),
                      CheckboxListTile(
                        value: _roles[1],
                        onChanged: (val) => setState(() {
                          _roles[1] = val;
                        }),
                        title: const Text("admin"),
                      ),
                    ],
                  )),
              const Divider(),
              // access role [user,admin,{join account access}]
              Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(right: 120),
                  child: const Text(
                    "preferred languages: ",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: const EdgeInsets.only(right: 140),
                  width: 200,
                  child: Column(
                    children: [
                      CheckboxListTile(
                        value: _langs[0],
                        onChanged: (val) => setState(() {
                          _langs[0] = val;
                        }),
                        title: const Text("English"),
                      ),
                      CheckboxListTile(
                        value: _langs[1],
                        onChanged: (val) => setState(() {
                          _langs[1] = val;
                        }),
                        title: const Text("hindi"),
                      ),
                      CheckboxListTile(
                        value: _langs[2],
                        onChanged: (val) => setState(() {
                          _langs[2] = val;
                        }),
                        title: const Text("Telugu"),
                      ),
                      CheckboxListTile(
                        value: _langs[3],
                        onChanged: (val) => setState(() {
                          _langs[3] = val;
                        }),
                        title: const Text("others"),
                      ),
                    ],
                  )),

              TextFormField(
                controller: otherLangController,
                enabled: _langs[3],
                decoration: InputDecoration(
                    hintText: 'enter language',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),

              //{optional}// signature field
              Column(
                children: const [],
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
                      onPressed: () {
                        if (_crateFormKey.currentState?.validate() ?? false) {
                          _crateFormKey.currentState?.save();
                          _handleSubmit();
                          _showScaffoldMessenger(
                              'user "${data.username}" has been created!');
                          try {
                            Connection().insert(data);
                            widget.setStateCallBack(index: -1);
                          } catch (ex) {
                            print(ex);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "something went wrong, please try again later")));
                          }
                          Navigator.pop(context);
                        }
                        //start else
                        // please fillout required details:

                        else {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: Colors.black12,
                              builder: (context) {
                                return Dialog(
                                  // alignment: AlignmentDirectional.bottomCenter,
                                  child: Container(
                                      padding: const EdgeInsets.all(20),
                                      height: 130,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            const Text(
                                                "please fillout required details: "),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("ok"),
                                            )
                                          ],
                                        ),
                                      )),
                                );
                              });
                        }

                        //end else
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

  _handleSubmit() {
    //gender
    switch (_gender) {
      case Gender.male:
        data.gender = "male";
        break;
      case Gender.female:
        data.gender = "female";
        break;
      case Gender.other:
        data.gender = "other";
        break;
      case Gender.none:
        data.gender = "none";
        break;
    }

    //roles
    data.roles = Role(admin: _roles[0], user: _roles[1]);

    //langs
    List<String> lst = [];
    if (_langs[0]) {
      lst.add("English");
    }
    if (_langs[1]) {
      lst.add("Hindi");
    }
    if (_langs[2]) {
      lst.add("Telugu");
    }
    if (_langs[3]) {
      lst.add(otherLangController.text);
    }
    data.language = Language(name: RealmList(lst));
  }

  _showScaffoldMessenger(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: RichText(
      text: TextSpan(children: [
        const TextSpan(
            text: "note! ", style: TextStyle(color: Colors.orangeAccent)),
        TextSpan(text: msg),
      ]),
    )));
  }
}
