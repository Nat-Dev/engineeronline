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

class EngineerVocab extends StatefulWidget {
  @override
  _EngineerVocabState createState() => _EngineerVocabState();
}

class _EngineerVocabState extends State<EngineerVocab> {
  // ตัวแปรใช้เก็บ widget สำหรับแสดงเป็น list ให้เลือก
  List<Widget> widgets = [];
  // ตัวแปรใช้เก็บ model เพื่อส่งไปหน้า view
  List<dynamic> generalModels = [];

  @override
  void initState() {
    super.initState();
    // เรียกใช้ฟังก์ชัน readData ก่อนการ build หน้านี้
    readData();
  }

  Future<Null> readData() async {
    // readData อ่านและเก็บข้อมูลของ collection นั้นๆลงใน ตัวแปรที่ประกาศไว้ด้านบน
    await Firebase.initializeApp().then((value) async {
      print("initialize engineer_vocab success");
      // เข้าถึงฐานข้อมูล Firestore collection นั้นๆ
      FirebaseFirestore.instance
          .collection("general_engineer_vocab")
          .orderBy('name')
          .snapshots()
          .listen((event) {
        int index = 0;
        for (var snapshot in event.docs) {
          // เช็ค type ของข้อมูลว่าเป็น yt, web, pdf ก่อนนำไปแสดงเป็น wiget
          Map<String, dynamic> map = snapshot.data();
          if (WebsiteModel.fromMap(map).type == "yt") {
            // change to youtube
            YoutubeModel model = YoutubeModel.fromMap(map);
            generalModels.add(model);
            setState(() {
              widgets.add(createYoutubeWidget(model, index));
            });
          } else if (WebsiteModel.fromMap(map).type == "web") {
            // change to web
            WebsiteModel model = WebsiteModel.fromMap(map);
            generalModels.add(model);
            setState(() {
              widgets.add(createWebWidget(model, index));
            });
          } else {
            // change to pdf
            PdfModel model = PdfModel.fromMap(map);
            generalModels.add(model);
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
        // widget ที่เป็น website เมื่อถูกกด ให้ส้ง model ที่ถูกกดไปยังหน้า views/website.dart
        // การเปลี่ยนหน้าจะที่นี้จะไม่ได้ใช้ชื่อที่เรียกจาก router.dart เพราะมีการส่งข้อมูล model
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Website(websiteModel: generalModels[index]),
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
                    // แสดงชื่อหัวข้อ หรือ name ของ model นั้นๆ
                    model.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(
                    // แสดงชื่อผู้โพสต์ของ model นั้นๆ
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
          // widget ที่เป็น youtube เมื่อถูกกด ให้ส้ง model ที่ถูกกดไปยังหน้า views/youtube.dart
          // การเปลี่ยนหน้าจะที่นี้จะไม่ได้ใช้ชื่อที่เรียกจาก router.dart เพราะมีการส่งข้อมูล model
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
                    // แสดงชื่อหัวข้อ หรือ name ของ model นั้นๆ
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
                  // แสดงชื่อผู้โพสต์ของ model นั้นๆ
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
          // widget ที่เป็น youtube เมื่อถูกกด ให้ส้ง model ที่ถูกกดไปยังหน้า views/pdf.dart
          // การเปลี่ยนหน้าจะที่นี้จะไม่ได้ใช้ชื่อที่เรียกจาก router.dart เพราะมีการส่งข้อมูล model
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Pdf(pdfModel: generalModels[index]),
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
                    // แสดงชื่อหัวข้อ หรือ name ของ model นั้นๆ
                    model.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(
                    // แสดงชื่อผู้โพสต์ของ model นั้นๆ
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
    // alert เมื่อยังไม่ได้เข้าสู่ระบบแล้วต้องการโพสต์ข้อมูลเพิ่ม
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
    // เมื่อเข้าสู่ระบบแล้วต้องการเพิ่มข้อมูล
    // การเพิ่มข้อมูลมี 3 แบบ website, youtube, pdf
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
                            WebPost("general_engineer_vocab")));
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
                            YoutubePost("general_engineer_vocab")));
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
                            PdfPost("general_engineer_vocab")));
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
          "คำศัพท์ภาษาอังกฤษทางวิศวกรรม",
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
          // ส่วนต่อท้ายของ appbar
          IconButton(
              icon: Icon(Icons.add), // เป็นเครื่องหมาย "+"
              onPressed: () async {
                // เมื่อถูกกด จะเช็คว่าเข้าสู่ระบบหรือยัง
                FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                User user = firebaseAuth.currentUser;
                if (user != null) {
                  // ถ้าเข้าสู่ระบบแล้ว แสดง postAlert() สำหรับเลือกรูปแบบข้อมูลที่จะโพสต์
                  postAlert();
                } else {
                  // ถ้ายังไม่เข้าสู่ระบบ แสดง authenAlert() บอกให้ผู้ใช้เข้าสู่ระบบก่อน
                  authenAlert();
                }
              })
        ],
      ),
      body: widgets.length == 0
          ? Center(child: CircularProgressIndicator())
          : Container(
              // background สี yellow.shade100
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
              ),
              child: ListView(
                // แสดง listview ด้วย ตัวแปร widgets ที่เก็บข้อมูลของ collection นั้นๆ
                children: widgets,
              ),
            ),
    );
  }
}
