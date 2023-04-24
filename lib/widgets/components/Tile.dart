import 'dart:io';

import 'package:flutter/material.dart';
import 'package:superuser/helper/realm/Connection.dart';

import '../../helper/realm/source/person.dart';
import 'editForm.dart';

class TileGenerator {
  void Function() init;

  TileGenerator(this.init);

  getList() {
    var data = Connection().getUserList();
    var list = <Widget>[];
    for (var person in data) {
      list.add(Tile(person, init));
    }
    return SingleChildScrollView(child: Column(children: list));
  }
}

class Tile extends StatefulWidget {
  // final String name;
  final Person data;
  void Function() init;

  Tile(this.data, this.init, {Key? key}) : super(key: key);

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  String imagePlaceHolder = "assets/loading/profile_placeholder.jpg";
  late String image;
  late String name;

  @override
  void initState() {
    super.initState();
    image = widget.data.imageUrl ?? imagePlaceHolder;
    name = widget.data.username;
  }

  imageProvider(String check) {
    if (check.isNotEmpty || check != null) {
      return FileImage(File(image));
    }
    return AssetImage(imagePlaceHolder);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          // left: 10, right: 10,
          bottom: 5),
      child: Material(
        elevation: 5,
        color: Colors.white,
        shadowColor: Colors.black26,
        child: ListTile(
          contentPadding:
              const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          leading: CircleAvatar(
            foregroundImage: FileImage(File(image)),
            backgroundImage: AssetImage(imagePlaceHolder),
            backgroundColor: Colors.transparent,
          ),
          title: RichText(
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                    text: name, //dynamic
                    style: const TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          onTap: () {
            setState(() {
              _showDialogBox(context, widget.init, widget.data);
            });
          },
          trailing: TextButton(
              onPressed: () {
                _handleDelete();
              },
              child: const Icon(
                Icons.delete_sharp,
                color: Colors.redAccent,
              )),
        ),
      ),
    );
  }

  _handleDelete() {
    return showDialog(
        context: context,
        barrierColor: Colors.black26,
        builder: (BuildContext context) {
          return Dialog(
            shadowColor: Colors.redAccent,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Are you sure?",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    // spacing: 20,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            print(widget.data.username);
                            Connection().deleteUser(widget.data);
                            widget.init();
                            Navigator.pop(context);
                          },
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(01.0)),
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.grey))),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(8),
                              shadowColor:
                                  MaterialStatePropertyAll(Colors.green)),
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.green),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showDialogBox(
    context,
    init,
    data,
  ) {
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
                child: EditForm(data, init),
              ),
            ),
          );
        });
  }

  getText(String fieldName, String? fieldData) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: fieldName,
              style: const TextStyle(color: Colors.black87),
            ),
            TextSpan(
              text: fieldData,
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
