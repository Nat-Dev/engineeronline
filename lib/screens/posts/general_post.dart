import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralPost extends StatefulWidget {
  @override
  _GeneralPostState createState() => _GeneralPostState();
}

class _GeneralPostState extends State<GeneralPost> {
  String name = "";
  String url = "";
  String img;
  final firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          Icons.web_asset,
          color: Colors.blue.shade700,
          size: 48.0,
        ),
        labelText: "URL :",
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
        if (value.contains('http') &&
            value.contains('://') &&
            value.contains('.')) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "เพิ่มหัวข้อ",
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
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            topicText(),
            SizedBox(
              height: 60.0,
            ),
            urlText(),
            SizedBox(
              height: 100.0,
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
                    await firestore.collection("General").add({
                      'name': name,
                      'url': url,
                    });
                  } catch (e) {
                    String code = e.code;
                    String message = e.message;
                    print("ERROR : $message CODE: $code");
                  }
                  // firestore.collection("General").add({
                  //   'name': name,
                  //   'url': url,
                  // });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
