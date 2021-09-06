import 'package:auto_size_text/auto_size_text.dart';
import 'package:engineeronline/models/pdf_model.dart';
import 'package:engineeronline/models/website_model.dart';
import 'package:engineeronline/models/youtube_model.dart';
import 'package:engineeronline/screens/posts/pdf_post.dart';
import 'package:engineeronline/screens/posts/web_post.dart';
import 'package:engineeronline/screens/posts/youtube_post.dart';
import 'package:engineeronline/screens/views/pdf.dart';
import 'package:engineeronline/screens/views/website.dart';
import 'package:engineeronline/screens/views/youtube.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ColumnWork extends StatefulWidget {
  @override
  _ColumnWorkState createState() => _ColumnWorkState();
}

class _ColumnWorkState extends State<ColumnWork> {
  List<Widget> widgets = [];
  List<dynamic> techniqueModels = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print("initialize column_work success");
      FirebaseFirestore.instance
          .collection("technique_column_work")
          .orderBy('name')
          .snapshots()
          .listen((event) {
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          if (WebsiteModel.fromMap(map).type == "yt") {
            // change to youtube
            YoutubeModel model = YoutubeModel.fromMap(map);
            techniqueModels.add(model);
            setState(() {
              widgets.add(createYoutubeWidget(model, index));
            });
          } else if (WebsiteModel.fromMap(map).type == "web") {
            // change to web
            WebsiteModel model = WebsiteModel.fromMap(map);
            techniqueModels.add(model);
            setState(() {
              widgets.add(createWebWidget(model, index));
            });
          } else {
            // change to pdf
            PdfModel model = PdfModel.fromMap(map);
            techniqueModels.add(model);
            setState(() {
              widgets.add(createPdfWidget(model, index));
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
                    Website(websiteModel: techniqueModels[index]),
              ));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          margin: EdgeInsets.all(4.0),
          padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Card(
            margin: EdgeInsets.all(8.0),
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
        ),
      );

  Widget createYoutubeWidget(YoutubeModel model, int index) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Youtube(youtubeModel: techniqueModels[index]),
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

  Widget createPdfWidget(PdfModel model, int index) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Pdf(pdfModel: techniqueModels[index]),
              ));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          margin: EdgeInsets.all(4.0),
          padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Card(
            margin: EdgeInsets.all(8.0),
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
              Icons.add_to_photos_rounded,
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
                            WebPost("technique_column_work")));
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
                            YoutubePost("technique_column_work")));
              },
            ),
            TextButton(
              child: Text("PDF"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PdfPost("technique_column_work")));
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
          "งานเสา(Column)",
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
