import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engineeronline/models/youtube_model.dart';
import 'package:engineeronline/screens/views/youtube.dart';
import 'package:flutter/material.dart';

class Technique extends StatefulWidget {
  @override
  _TechniqueState createState() => _TechniqueState();
}

class _TechniqueState extends State<Technique> {
  List<Widget> widgets = [];
  List<YoutubeModel> techniqueModels = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print("initialize technique success");
      FirebaseFirestore.instance
          .collection("Technique")
          .snapshots()
          .listen((event) {
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          YoutubeModel model = YoutubeModel.fromMap(map);
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

  Widget createWidget(YoutubeModel model, int index) => GestureDetector(
        onTap: () {
          print("${model.name} clicked index = $index");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Youtube(youtubeModel: techniqueModels[index]),
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
                Flexible(
                  child: AutoSizeText(
                    model.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                AutoSizeText(
                  model.username,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void authenAlert() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              Icons.assignment_late,
              color: Colors.red,
              size: 48.0,
            ),
            title: Text(
              "ไม่สามารถเพิ่มหัวข้อใหม่ได้",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Text("กรุณาเข้าสู่ระบบเพื่อเพิ่มหัวข้อใหม่"),
          actions: <Widget>[
            TextButton(
              child: Text("ปิด"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("สร้างบัญชีใหม่"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/register');
              },
            ),
            TextButton(
              child: Text("เข้าสู่ระบบ"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/authen');
              },
            )
          ],
        );
      },
    );
  }

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
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                User user = firebaseAuth.currentUser;
                if (user != null) {
                  Navigator.pushNamed(context, '/technique_post');
                } else {
                  print("please sign in first");
                  authenAlert();
                }
              })
        ],
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
