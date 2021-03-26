import 'package:engineeronline/screens/posts/general_post.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engineeronline/models/website_model.dart';
import 'package:engineeronline/screens/views/website.dart';
import 'package:flutter/material.dart';

class General extends StatefulWidget {
  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  List<Widget> widgets = [];
  List<WebsiteModel> generalModels = [];

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
          WebsiteModel model = WebsiteModel.fromMap(map);
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

  Widget createWidget(WebsiteModel model, int index) => GestureDetector(
        onTap: () {
          print("${model.name} clicked index = $index");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Website(websiteModel: generalModels[index]),
              ));
        },
        child: Card(
          color: Colors.amber.shade100,
          elevation: 5,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    builder: (BuildContext context) => GeneralPost());
                Navigator.of(context).push(materialPageRoute);
              })
        ],
      ),
      body: widgets.length == 0
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: GridView.extent(
                maxCrossAxisExtent: 180,
                children: widgets,
              ),
            ),
    );
  }
}
