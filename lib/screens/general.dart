import 'package:engineeronline/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engineeronline/models/webview_model.dart';
import 'package:engineeronline/screens/webview.dart';
import 'package:flutter/material.dart';

class General extends StatefulWidget {
  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  List<Widget> widgets = [];
  List<WebViewModel> generalModels = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print("initialize general success");
      await FirebaseFirestore.instance
          .collection("General")
          .snapshots()
          .listen((event) {
        // print('snapshot = ${event.docs}');
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          // print("map = $map");
          WebViewModel model = WebViewModel.fromMap(map);
          generalModels.add(model);
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
                    Webview(webviewModel: generalModels[index]),
              ));
        },
        child: Card(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  child: Image.network(model.thumbnail),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  model.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );

  Widget backButton() {
    return IconButton(
      icon: Icon(
        Icons.navigate_before,
        size: 36.0,
        color: Colors.white,
      ),
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Home());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: backButton(),
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "ความรู้วิศวกรรมในงานก่อสร้าง",
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
                maxCrossAxisExtent: 180,
                children: widgets,
              ),
            ),
    );
  }
}
