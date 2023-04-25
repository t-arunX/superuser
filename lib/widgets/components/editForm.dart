import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realm/realm.dart';
import 'package:superuser/helper/realm/Connection.dart';

import '../../helper/realm/source/person.dart';
import '../HomePage.dart';
import '../LandingPage.dart';

class EditForm extends StatefulWidget {
  final Person data;
  final Function setStateCallBack;

  const EditForm(this.data,this.setStateCallBack, {Key? key}) : super(key: key);

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

  late Person data = Person(widget.data.userId, "");


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
          Connection().updateImage(data, widget.data);
        });
      } catch (ex) {
        print(ex);
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
            children: [
              const SizedBox(height: 20),
              // SizedBox(
              //   height: 170,
              //   width: double.infinity,
              //   child: CircleAvatar(
              //     backgroundImage: NetworkImage(image, scale: 10),
              //     // radius: 100,
              //   ),
              // ),
              Badge(
                backgroundColor: Colors.transparent,
                alignment: const AlignmentDirectional(190, 110),
                largeSize: 90,
                label: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        pressedEdit = true;
                        globalEnable = globalEnable == true ? false : true;
                      });
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
              TextFormField(
                decoration: const InputDecoration(
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
                    hintText: 'city', errorStyle: TextStyle(color: Colors.red)),
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
                      onPressed: !pressedEdit ? null : () {
                        if (_editFormKey.currentState?.validate() ?? false) {
                          // handlers.map((e) => e.dispose());
                          if (pressedEdit) {
                            _editFormKey.currentState?.save();
                            try {
                              data.imageUrl = imgPath;
                              Connection().updateUser(data, widget.data);
                              widget.setStateCallBack();
                            } catch (ex) {
                              if (kDebugMode) {
                                print('Button error: $ex');
                              }
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("something went wrong, please try again later")));
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
}
