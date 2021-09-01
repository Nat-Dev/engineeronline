import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgot-password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String _email;

  _passwordReset() async {
    if (_formKey.currentState.validate()) {
      try {
        _formKey.currentState.save();
        await _auth.sendPasswordResetEmail(email: _email);

        resetSuccessAlert();
      } on FirebaseAuthException catch (e) {
        print(e.code);
        resetFailAlert(e.code);
      }
    }
  }

  void resetFailAlert(String message) {
    String msg = message;
    if (msg == 'user-not-found') {
      msg = 'ไม่มีบัญชีผู้ใช้นี้ในระบบ';
    }
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
              "ไม่สามารถส่งอีเมลล์ได้",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void resetSuccessAlert() {
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
              "ทำการส่งอีเมลล์แล้ว",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(
              "อีเมลล์รีเซ็ตรหัสผ่านได้ถูกส่งไปยังอีเมลล์ของท่าน, กรุณาคลิกลิ้งค์ในอีเมลล์เพื่อทำการตั้งรหัสผ่านใหม่"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget backButton() {
    return Align(
      alignment: Alignment(-1, 0),
      child: IconButton(
        icon: Icon(
          Icons.navigate_before,
          size: 36.0,
          color: Colors.blue.shade700,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget header() {
    return Align(
      alignment: Alignment(0, 0),
      child: Text(
        "รีเซ็ตรหัสผ่านใหม่",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      body: Form(
        key: _formKey,
        child: ListView(children: [
          backButton(),
          header(),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 30.0, vertical: height / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'กรอกที่อยู่อีเมลล์บัญชีผู้ใช้ของท่าน',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (String value) {
                    if ((value.contains('@')) && (value.contains('.'))) {
                      return null;
                    } else {
                      return "กรุณากรอกอีเมลล์บัญชีผู้ใช้ของท่านให้ถูกต้อง";
                    }
                  },
                  onSaved: (newEmail) {
                    _email = newEmail;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'อีเมลล์',
                    icon: Icon(
                      Icons.mail,
                      color: Colors.black,
                      size: 36.0,
                    ),
                    errorStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade400,
                    onPrimary: Colors.black,
                  ),
                  child: Text('ส่งอีเมลล์'),
                  onPressed: () {
                    _passwordReset();
                    print(_email);
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
