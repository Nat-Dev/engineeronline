import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engineeronline/screens/general.dart';
import 'package:engineeronline/screens/home.dart';
import 'package:flutter/material.dart';

class GeneralPost extends StatefulWidget {
  @override
  _GeneralPostState createState() => _GeneralPostState();
}

class _GeneralPostState extends State<GeneralPost> {
  String name = "";
  String url = "";
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
          content: Text("กด OK เพื่อไปยัง ความรู้วิศวกรรมในงานก่อสร้าง"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                MaterialPageRoute materialPageRouteHome = MaterialPageRoute(
                    builder: (BuildContext context) => Home());
                Navigator.of(context).pushAndRemoveUntil(
                    materialPageRouteHome, (Route<dynamic> route) => false);
                MaterialPageRoute materialPageRouteGeneral = MaterialPageRoute(
                    builder: (BuildContext context) => General());
                Navigator.of(context).push(materialPageRouteGeneral);
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
          "เพิ่ม ความรู้วิศวกรรมในงานก่อสร้าง",
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
                      await firestore.collection("General").add({
                        'name': name,
                        'url': url,
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
