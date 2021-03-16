import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engineeronline/models/webview_model.dart';
import 'package:engineeronline/screens/webview.dart';
import 'package:flutter/material.dart';

class Technique extends StatefulWidget {
  @override
  _TechniqueState createState() => _TechniqueState();
}

class _TechniqueState extends State<Technique> {
  List<Widget> widgets = [];
  List<WebViewModel> techniqueModels = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print("initialize technique success");
      await FirebaseFirestore.instance
          .collection("Technique")
          .snapshots()
          .listen((event) {
        // print('snapshot = ${event.docs}');
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          // print("map = $map");
          WebViewModel model = WebViewModel.fromMap(map);
          techniqueModels.add(model);
          print("name = ${model.name}");
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  Widget createWidget(WebViewModel model, int index) => GestureDetector(
        onTap: () {
          print("${model.name} clicked index = $index");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Webview(webviewModel: techniqueModels[index]),
              ));
        },
        child: Card(
          elevation: 5,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 180,
                  child: Image.network(model.thumbnail),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  model.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "เทคนิคการก่อสร้าง",
          style: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            shadows: [
              Shadow(
                offset: Offset(1.75, 1.75),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              )
            ],
          ),
        ),
      ),
      body: widgets.length == 0
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: GridView.extent(
                maxCrossAxisExtent: 260,
                children: widgets,
              ),
            ),
    );
  }
}
