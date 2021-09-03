import 'package:auto_size_text/auto_size_text.dart';
import 'package:engineeronline/models/website_model.dart';
import 'package:engineeronline/models/youtube_model.dart';
import 'package:engineeronline/screens/posts/web_post.dart';
import 'package:engineeronline/screens/posts/youtube_post.dart';
import 'package:engineeronline/screens/views/website.dart';
import 'package:engineeronline/screens/views/youtube.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StructureWork extends StatefulWidget {
  @override
  _StructureWorkState createState() => _StructureWorkState();
}

class _StructureWorkState extends State<StructureWork> {
  List<Widget> widgets = [];
  List<dynamic> generalModels = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print("initialize structure_work success");
      FirebaseFirestore.instance
          .collection("general_structure_work")
          .orderBy('name')
          .snapshots()
          .listen((event) {
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          if (WebsiteModel.fromMap(map).type == "yt") {
            // change to youtube
            YoutubeModel model = YoutubeModel.fromMap(map);
            generalModels.add(model);
            setState(() {
              widgets.add(createYoutubeWidget(model, index));
            });
          } else {
            // change to web
            WebsiteModel model = WebsiteModel.fromMap(map);
            generalModels.add(model);
            setState(() {
              widgets.add(createWebWidget(model, index));
            });
          }
          index++;
        }
      });
    });
  }

  Widget createWebWidget(WebsiteModel model, int index) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Website(websiteModel: generalModels[index]),
              ));
        },
        child: Card(
          elevation: 5,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  model.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                AutoSizeText(
                  'โดย ' + model.username,
                  maxLines: 1,
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

  Widget createYoutubeWidget(YoutubeModel model, int index) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Youtube(youtubeModel: generalModels[index]),
              ));
        },
        child: Card(
          color: Colors.grey.shade900,
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
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                AutoSizeText(
                  model.username,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
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

  void postAlert() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              Icons.add_box_rounded,
              color: Colors.green,
              size: 48.0,
            ),
            title: Text(
              "กรุณาเลือกรูปแบบของหัวข้อ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(
              "เพิ่มหัวข้อใหม่แบบ Website, YouTube, PDF หรือแตะพื้นที่นอกกรอบเพื่อยกเลิก"),
          actions: <Widget>[
            TextButton(
              child: Text("Website"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WebPost("general_structure_work")));
              },
            ),
            TextButton(
              child: Text("YouTube"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            YoutubePost("general_structure_work")));
              },
            ),
            TextButton(
              child: Text("PDF"),
              onPressed: () {
                Navigator.pop(context);
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
        title: AutoSizeText(
          "งานโครงสร้าง",
          maxLines: 1,
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
                  postAlert();
                } else {
                  authenAlert();
                }
              })
        ],
      ),
      body: widgets.length == 0
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(color: Colors.yellow.shade100),
              child: ListView(
                children: widgets,
              ),
            ),
    );
  }
}
