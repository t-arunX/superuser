import 'package:flutter/material.dart';

import 'components/Tile.dart';
import 'components/createForm.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Widget data;

  fetch() {
    Widget res = TileGenerator(fetch).getList();
    setState(() {
      data = res;
    });
  }


  @override
  void initState() {
    super.initState();
    setState(() {
      data = TileGenerator(fetch).getList();
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
        child: data,
      ),
      floatingActionButton: ElevatedButton(
        style: const ButtonStyle(elevation: MaterialStatePropertyAll(8),shadowColor: MaterialStatePropertyAll(Colors.deepPurple)),
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
