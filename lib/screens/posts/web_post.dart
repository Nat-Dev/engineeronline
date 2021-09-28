import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class WebPost extends StatefulWidget {
  // collection เก็บค่าของหัวข้อใหญ่ เช่น general_engineer_vocab, technique_scaffolding
  final String collection;
  // รับค่า collection เพื่อใช้บอกว่าจะเพิ่มข้อมูลใน collection ไหน
  WebPost(this.collection);
  @override
  _WebPostState createState() => _WebPostState(collection);
}

class _WebPostState extends State<WebPost> {
  // ตัวแปรต่างๆสำหรับการเพิ่มข้อมูล website
  String collection;
  String name = "";
  String url = "";
  String username, email;
  String type = "web";
  // ตัวแปรสำหรับใช้งานฐานข้อมูล Firestore
  final firestore = FirebaseFirestore.instance;

  // _formKey สำหรับ validate ข้อมูล
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _WebPostState(this.collection);

  @override
  void initState() {
    super.initState();
    findNameAndEmail();
  }

  Future<Null> findNameAndEmail() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseAuth.instance.authStateChanges().listen((event) {
        if (mounted) {
          setState(() {
            username = event.displayName;
            email = event.email;
          });
        }
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
    // ช่องกรอก url ของเว็บไซต์
    return TextFormField(
      keyboardType: TextInputType.url,
      decoration: InputDecoration(
        icon: Icon(
          Icons.web_asset,
          color: Colors.blue.shade700,
          size: 48.0,
        ),
        labelText: "Website URL :",
        labelStyle: TextStyle(
          color: Colors.blue.shade700,
          fontWeight: FontWeight.bold,
        ),
        helperText: "กรุณาใส่ URL ของเว็บไซต์อ้างอิง",
        helperStyle: TextStyle(
          color: Colors.blue.shade700,
          fontStyle: FontStyle.italic,
          fontSize: 16.0,
        ),
      ),
      validator: (String value) {
        if (value.contains('https') &&
            value.contains('://') &&
            value.contains('.')) {
          // validate สิ่งที่ต้องมีใน url "https", "://", "."
          // บังคับให้กรอกได้เฉพาะ url ที่ใช้โปรโตคอล https เท่านั้น
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
          content: Text("กด OK เพื่อกลับสู่หน้าหลัก"),
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
          "เพิ่มเว็บไซต์อ้างอิง",
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
              urlText(), // ช่องกรอก url ของเว็บไซต์
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
                      await firestore.collection(collection).add({
                        'name': name,
                        'url': url,
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
