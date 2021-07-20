import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TechniquePost extends StatefulWidget {
  final String collection;
  TechniquePost(this.collection);
  @override
  _TechniquePostState createState() => _TechniquePostState(collection);
}

class _TechniquePostState extends State<TechniquePost> {
  String collection;
  String name = "";
  String url = "";
  String img = "";
  String username, email;
  final firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _TechniquePostState(this.collection);

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
          return null;
        } else {
          return "กรุณาใส่ชื่อหัวข้อให้ถูกต้อง";
        }
      },
      onSaved: (String value) {
        name = value.trim();
      },
    );
  }

  Widget urlText() {
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
          return null;
        } else if (value.contains('https://') && value.contains('youtu.be/')) {
          return null;
        } else {
          return "กรุณาใส่ URL ให้ถูกต้อง";
        }
      },
      onSaved: (String value) {
        url = value.trim();
      },
    );
  }

  String getYoutubeThumbnail(String videoUrl) {
    final Uri uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return null;
    } else if (videoUrl.contains("/watch?v=")) {
      img = "https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg";
    } else if (videoUrl.contains("youtu.be/")) {
      img = videoUrl.replaceAll(
          "https://youtu.be/", 'https://img.youtube.com/vi/');
      img = img + '/0.jpg';
    }
    return img;
  }

  void postSuccessAlert() {
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
          "เพิ่ม เทคนิคการก่อสร้าง",
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
              topicText(),
              SizedBox(
                height: screenHeight * 0.17,
              ),
              urlText(),
              SizedBox(
                height: screenHeight * 0.23,
              ),
              ElevatedButton(
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
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    try {
                      print(getYoutubeThumbnail(url));
                      await firestore.collection(collection).add({
                        'name': name,
                        'url': url,
                        'thumbnail': img,
                        'username': username,
                        'email': email
                      });
                      postSuccessAlert();
                    } catch (e) {
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
