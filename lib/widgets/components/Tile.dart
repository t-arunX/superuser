import 'dart:io';

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:superuser/helper/realm/Connection.dart';
import 'package:superuser/model/PersonModel.dart';

import 'editForm.dart';

class Tile extends StatefulWidget {
  PersonModel data;
  Function fetch;
  int? index;

  Tile(this.data, this.index, this.fetch, {Key? key}) : super(key: key);

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  String imagePlaceHolder = "assets/loading/profile_placeholder.jpg";
  late String image;
  late String name;

  late PersonModel personModel;

  void refresh() {
    // if (kDebugMode) {
    //   print("__refresh() called");
    // }
    setState(() {
      image = widget.data.imageUrl ?? imagePlaceHolder;
      name = widget.data.username!;
      personModel = widget.data;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // if (kDebugMode) {
    //   print("__didchangedependencies: $name");
    // }
    refresh();
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  imageProvider(String image) {
    if (image.isNotEmpty) {
      return FileImage(File(image));
    }
    return AssetImage(imagePlaceHolder);
  }

  @override
  Widget build(BuildContext context) {
    refresh();
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
            foregroundImage:
                FileImage(File(widget.data.imageUrl ?? imagePlaceHolder)),
            backgroundImage: AssetImage(imagePlaceHolder),
            backgroundColor: Colors.transparent,
          ),
          title: RichText(
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                    text: name ?? "N/A", //dynamic
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 17)),
              ],
            ),
          ),
          onTap: () {
            setState(() {
              _showDialogBox(context, widget.fetch, widget.data);
            });
          },
          trailing: TextButton(
              onLongPress: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.black87,
                    behavior: SnackBarBehavior.floating,
                    elevation: 0,
                    showCloseIcon: true,
                    width: 200,
                    dismissDirection: DismissDirection.endToStart,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    content: Text('long press to delete'),
                    duration: Duration(seconds: 2),
                    closeIconColor: Colors.grey,
                  ),
                );
              },
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
            shadowColor: Colors.black,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                            text: "Are you sure?", //dynamic
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                            text: "you want to ", //dynamic
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400)),
                        TextSpan(
                            text: "Delete", //dynamic
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Material(
                    elevation: 5,
                    color: Colors.white,
                    shadowColor: Colors.black26,
                    child: ListTile(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
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
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                      ),
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
                            Connection().deleteUser(
                                ObjectId.fromHexString(personModel.userId));
                            widget.fetch(index: widget.index);
                            _showScaffoldMessenger(
                                ' "$name"  has been deleted');
                            Navigator.pop(context);
                          },
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(01.5),
                              shadowColor:
                                  MaterialStatePropertyAll(Colors.redAccent)),
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.black26))),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(5),
                              shadowColor:
                                  MaterialStatePropertyAll(Colors.green)),
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.lightGreen),
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

  _showScaffoldMessenger(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: RichText(
      text: TextSpan(children: [
        const TextSpan(text: "warning! ", style: TextStyle(color: Colors.red)),
        TextSpan(text: msg),
      ]),
    )));
  }
}
