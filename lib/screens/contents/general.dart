import 'package:auto_size_text/auto_size_text.dart';
import 'package:engineeronline/screens/posts/web_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      FirebaseFirestore.instance
          .collection("General")
          .snapshots()
          .listen((event) {
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
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
                AutoSizeText(
                  model.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                AutoSizeText(
                  'โดย ' + model.username,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
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
              onPressed: () async {
                FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                User user = firebaseAuth.currentUser;
                if (user != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebPost("General")));
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
