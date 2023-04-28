import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:superuser/helper/realm/Connection.dart';

import '../../model/PersonModel.dart';

class EditForm extends StatefulWidget {
  PersonModel data;
  final Function setStateCallBack;

  EditForm(this.data, this.setStateCallBack, {Key? key}) : super(key: key);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  bool globalEnable = false;
  final _editFormKey = GlobalKey<FormState>();
  var usernameHandler = TextEditingController();
  var firstnameHandler = TextEditingController();
  var lastnameHandler = TextEditingController();
  var cityHandler = TextEditingController();
  var stateHandler = TextEditingController();
  var countryHandler = TextEditingController();

  late List handlers;

  String imagePlaceHolder = "assets/loading/profile_placeholder.jpg";
  late String image;

  bool pressedEdit = false;

  late PersonModel data = PersonModel(userId: widget.data.userId, username: "");

  String? imgPath;

  late List _roles;

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
          data.imageUrl = image!.path;
          imgPath = image.path;
          Connection().updateImage(image.path, widget.data.userId);
          widget.setStateCallBack(index: -1);
          _showScaffoldMessenger("changes have been made");
        });
      } catch (ex) {
        if (kDebugMode) {
          print("exception at image handler: $ex");
        }
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
    // data = widget.data;
    usernameHandler = TextEditingController(text: widget.data.username);
    firstnameHandler = TextEditingController(text: widget.data.firstname);
    lastnameHandler = TextEditingController(text: widget.data.lastname);
    cityHandler = TextEditingController(text: widget.data.city);
    stateHandler = TextEditingController(text: widget.data.state);
    countryHandler = TextEditingController(text: widget.data.country);

    // image = widget.data.imageUrl ?? imagePlaceHolder;

    imgPath = widget.data.imageUrl;

    // handlers.addAll([usernameHandler,firstnameHandler,lastnameHandler,cityHandler,stateHandler,countryHandler]);

    _roles = [
      widget.data.roles?.admin ?? false,
      widget.data.roles?.user ?? false
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _editFormKey,
      child: ClipRect(
        child: Container(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          // color: Colors.white60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Badge(
                backgroundColor: Colors.transparent,
                alignment: const AlignmentDirectional(190, 110),
                largeSize: 90,
                label: ElevatedButton(
                    onPressed: () {
                      // setState(() {
                      //   // pressedEdit = true;
                      //   // globalEnable = globalEnable == true ? false : true;
                      // });
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
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      globalEnable = globalEnable == true ? false : true;
                      pressedEdit = true;
                    });
                  },
                  child: const Icon(Icons.edit_rounded),
                ),
              ),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                    hintText: 'Id: ${widget.data.userId}',
                    hintStyle: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              TextFormField(
                // initialValue: data.username,
                enabled: globalEnable,
                decoration: const InputDecoration(
                    hintText: 'username',
                    errorStyle: TextStyle(color: Colors.red)),
                validator: (value) {
                  return value == '' || value!.contains("@")
                      ? "text field can't be empty"
                      : null;
                },
                onSaved: (value) {
                  data.username = value!;
                },
                controller: usernameHandler,
                autofillHints: const ["username", "password"],
              ),
              SizedBox(
                width: 300,
                // height: 80,
                child: IntlPhoneField(
                  initialValue: widget.data.mobile?.number ?? "",
                  enabled: globalEnable,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number *',
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    // ),
                  ),
                  initialCountryCode: 'IN',
                  onSaved: (val) {
                    data.mobile =
                        MobileM(pin: val?.countryISOCode, number: val?.number);
                  },
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    helperText: "firstname",
                    hintText: 'firstname',
                    errorStyle: TextStyle(color: Colors.red)),
                validator: (value) {
                  return value == '' || value!.contains("@")
                      ? "text field can't be empty"
                      : null;
                },
                onSaved: (value) {
                  data.firstname = value!;
                },
                controller: firstnameHandler,
                enabled: globalEnable,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    helperText: "lastname",
                    hintText: 'lastname',
                    errorStyle: TextStyle(color: Colors.red)),
                validator: (value) {
                  return value == '' || value!.contains("@")
                      ? "text field can't be empty"
                      : null;
                },
                onSaved: (value) {
                  data.lastname = value!;
                },
                controller: lastnameHandler,
                enabled: globalEnable,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    helperText: "city",
                    hintText: 'city',
                    errorStyle: TextStyle(color: Colors.red)),
                validator: (value) {
                  // print(value);
                  return value == '' || value!.contains("@")
                      ? "text field can't be empty"
                      : null;
                },
                onSaved: (value) {
                  data.city = value!;
                },
                controller: cityHandler,
                enabled: globalEnable,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    helperText: "state",
                    hintText: 'state',
                    errorStyle: TextStyle(color: Colors.red)),
                validator: (value) {
                  return value == '' || value!.contains("@")
                      ? "text field can't be empty"
                      : null;
                },
                onSaved: (value) {
                  data.state = value!;
                },
                controller: stateHandler,
                enabled: globalEnable,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    helperText: "country",
                    hintText: 'country',
                    errorStyle: TextStyle(color: Colors.red)),
                validator: (value) {
                  return value == '' || value!.contains("@")
                      ? "text field can't be empty"
                      : null;
                },
                onSaved: (value) {
                  data.country = value!;
                },
                controller: countryHandler,
                enabled: globalEnable,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Age: ",
                      style: TextStyle(color: Colors.deepPurple)),
                  TextSpan(
                      text:
                          "${getAge(widget.data.dob ?? "NA")} years" ?? "none",
                      style: const TextStyle(color: Colors.black54)),
                ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Gender: ",
                      style: TextStyle(color: Colors.deepPurple)),
                  TextSpan(
                      text: widget.data.gender ?? "none",
                      style: const TextStyle(color: Colors.black54)),
                ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: "preferred languages: ",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  ...?widget.data.language?.name?.mapIndexed((i, langs) {
                    if (widget.data.language?.name?.length == i + 1) {
                      // print(widget.data.language?.name.length );
                      return TextSpan(
                        text: '$langs.',
                        style: const TextStyle(color: Colors.grey),
                      );
                    } else {
                      // print(i);
                      return TextSpan(
                        text: '$langs ,',
                        style: const TextStyle(color: Colors.grey),
                      );
                    }
                  }).toList(),
                ])),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 150),
                  width: 200,
                  child: Column(
                    children: [
                      CheckboxListTile(
                        enabled: globalEnable,
                        value: _roles[0],
                        onChanged: (val) => setState(() {
                          _roles[0] = val;
                        }),
                        title: const Text("user"),
                      ),
                      CheckboxListTile(
                        enabled: globalEnable,
                        value: _roles[1],
                        onChanged: (val) => setState(() {
                          _roles[1] = val;
                        }),
                        title: const Text("admin"),
                      ),
                    ],
                  )),
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
                      onPressed: !pressedEdit
                          ? null
                          : () {
                              if (_editFormKey.currentState?.validate() ??
                                  false) {
                                // handlers.map((e) => e.dispose());
                                if (pressedEdit) {
                                  _editFormKey.currentState?.save();
                                  try {
                                    data.imageUrl = imgPath;
                                    _handleSubmit();
                                    Connection()
                                        .updateUser(data, widget.data.userId);
                                    widget.setStateCallBack(index: -1);
                                  } catch (ex) {
                                    if (kDebugMode) {
                                      print('__onSubmit: $ex');
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "something went wrong, please try again later")));
                                  }
                                }
                                Navigator.pop(context);
                              }
                            },
                      child: const Text("save")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleSubmit() {
    data.roles = RoleM(user: _roles[1], admin: _roles[0]);
    data.language = widget.data.language ?? LanguageM();
  }

  _showScaffoldMessenger(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: RichText(
      text: TextSpan(children: [
        const TextSpan(text: "warning! ", style: TextStyle(color: Colors.red)),
        TextSpan(text: msg),
      ]),
    )));
  }

  getAge(String? date) {
    if (!(date == "NA")) {
      // DateTime dt1 = DateTime.parse(date!).year;
      // // print(date);
      // return dt1.difference(DateTime.now()).inDays.abs().toString();
      int dt1 = DateTime.parse(date!).year;
      return (dt1 - DateTime.now().year.abs()).toString();
    }
    return "";
  }
}
