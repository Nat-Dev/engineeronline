import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class YoutubePost extends StatefulWidget {
  // collection เก็บค่าของหัวข้อใหญ่ เช่น general_engineer_vocab, technique_scaffolding
  final String collection;
  YoutubePost(this.collection);
  // รับค่า collection เพื่อใช้บอกว่าจะเพิ่มข้อมูลใน collection ไหน
  @override
  _YoutubePostState createState() => _YoutubePostState(collection);
}

class _YoutubePostState extends State<YoutubePost> {
  // ตัวแปรต่างๆสำหรับการเพิ่มข้อมูล website
  String collection;
  String name = "";
  String url = "";
  String img = "";
  String username, email;
  String type = "yt";

  // ตัวแปรสำหรับใช้งานฐานข้อมูล Firestore
  final firestore = FirebaseFirestore.instance;
  // _formKey สำหรับ validate ข้อมูล
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _YoutubePostState(this.collection);

  @override
  void initState() {
    super.initState();
    findNameAndEmail();
  }

  Future<Null> findNameAndEmail() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          username = event.displayName;
          email = event.email;
        });
      });
    });
    print("username = $username, email = $email");
  }

  Widget topicText() {
    // ช่องกรอกชื่อหัวข้อ
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        icon: Icon(
          Icons.book,
          color: Colors.blue.shade700,
          size: 48.0,
        ),
        labelText: "ชื่อหัวข้อ :",
        labelStyle: TextStyle(
          color: Colors.blue.shade700,
          fontWeight: FontWeight.bold,
        ),
        helperText: "กรุณาใส่ชื่อหัวข้อ",
        helperStyle: TextStyle(
          color: Colors.blue.shade700,
          fontStyle: FontStyle.italic,
          fontSize: 16.0,
        ),
      ),
      validator: (String value) {
        if (value.isNotEmpty) {
          // ชื่อหัวข้อต้องถูกกรอก
          return null;
        } else {
          return "กรุณาใส่ชื่อหัวข้อให้ถูกต้อง";
        }
      },
      onSaved: (String value) {
        // validate สำเร็จ save ค่า
        name = value.trim();
      },
    );
  }

  Widget urlText() {
    // ช่องกรอก url ของ youtube
    return TextFormField(
      keyboardType: TextInputType.url,
      decoration: InputDecoration(
        icon: Icon(
          Icons.video_collection,
          color: Colors.blue.shade700,
          size: 48.0,
        ),
        labelText: "Youtube URL :",
        labelStyle: TextStyle(
          color: Colors.blue.shade700,
          fontWeight: FontWeight.bold,
        ),
        helperText: "กรุณาใส่ URL ของ Youtube",
        helperStyle: TextStyle(
          color: Colors.blue.shade700,
          fontStyle: FontStyle.italic,
          fontSize: 16.0,
        ),
      ),
      validator: (String value) {
        if (value.contains('https://') &&
            value.contains('.') &&
            value.contains('youtube') &&
            value.contains('/watch?v=')) {
          // validate สิ่งที่ต้องมีใน url ของ youtube ที่เป็น website url
          return null;
        } else if (value.contains('https://') && value.contains('youtu.be/')) {
          // validate สิ่งที่ต้องมีใน url ของ youtube ที่เป็น mobile_web url
          return null;
        } else {
          return "กรุณาใส่ URL ให้ถูกต้อง";
        }
      },
      onSaved: (String value) {
        // validate สำเร็จ save ค่า
        url = value.trim();
      },
    );
  }

  String getYoutubeThumbnail(String videoUrl) {
    // ฟังก์ชัน generate ภาพปกของ youtube จาก url
    final Uri uri = Uri.tryParse(videoUrl); // รับค่า url
    if (uri == null) {
      // ถ้า url เป็น null ให้ return null เลย
      // case นี้จะไม่เกิดขึ้น
      return null;
    } else if (videoUrl.contains("/watch?v=")) {
      // กรณีเป็น url จาก web base youtube ให้อัพเดทค่า img ตามด้านล่าง
      img = "https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg";
    } else if (videoUrl.contains("youtu.be/")) {
      // กรณีเป็น url จาก mobile base youtube ให้อัพเดทค่า img ตามด้านล่าง
      img = videoUrl.replaceAll(
          "https://youtu.be/", 'https://img.youtube.com/vi/');
      img = img + '/0.jpg';
    }
    // return ค่า img ไปใช้งาน
    return img;
  }

  void postSuccessAlert() {
    // dialog เมื่อโพสต์สำเร็จ
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              Icons.assignment_turned_in,
              color: Colors.lightGreenAccent.shade400,
              size: 48.0,
            ),
            title: Text(
              "เพิ่มหัวข้อสำเร็จ",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Text("กด OK เพื่อกลับหน้าหลัก"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                // กด OK ใน dialog เพื่อกลับสู่หน้าหลัก '/home_signedin'
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home_signedin', (route) => false);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "เพิ่มวีดีโอ YouTube",
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
      body: Form(
        key: _formKey,
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(30.0),
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.08,
              ),
              topicText(), // ช่องกรอกชื่อหัวข้อ
              SizedBox(
                height: screenHeight * 0.17,
              ),
              urlText(), // ช่องกรอก url ของ youtube
              SizedBox(
                height: screenHeight * 0.23,
              ),
              ElevatedButton(
                // ปุ่มกดเพิ่มหัวข้อ
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent.shade400,
                  onPrimary: Colors.white,
                ),
                child: Text(
                  'เพิ่มหัวข้อนี้',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  // เมื่อปุ่มถูกกดจะทำงานฟังก์ชัน onPressed
                  if (_formKey.currentState.validate()) {
                    // เช็ค formKey validate ทั้งหมด
                    _formKey.currentState.save();
                    try {
                      // เพิ่มข้อมูลลงใน collection นั้นๆของ firestore
                      // ข้อมูลที่เพิ่มคือข้อมูลของ model website
                      print(getYoutubeThumbnail(url));
                      await firestore.collection(collection).add({
                        'name': name,
                        'url': url,
                        'thumbnail': img,
                        'username': username,
                        'email': email,
                        'type': type
                      });
                      postSuccessAlert(); // แสดง dialog เมื่อเพิ่มข้อมูลสำเร็จ
                    } catch (e) {
                      // หากเพิ่มข้อมูลไม่สำเร็จ print error message และ error code
                      String code = e.code;
                      String message = e.message;
                      print("ERROR : $message CODE: $code");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
