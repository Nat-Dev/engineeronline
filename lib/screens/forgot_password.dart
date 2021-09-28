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
  // ใช้ _formKey สำหรับตรวจสอบข้อมูลเหมือนหน้า Authen
  String _email;

  _passwordReset() async {
    if (_formKey.currentState.validate()) {
      // เช็คการ validate ข้อมูล ถ้าถูกต้องให้ทำต่อด้านล่าง
      try {
        _formKey.currentState.save();
        // save ข้อมูลที่ผู้ใช้กรอก ซึ่งก็คือ Email
        // ส่ง Email สำหรับ reset password ไปยัง Email ที่ผู้ใช้กรอก
        await _auth.sendPasswordResetEmail(email: _email);

        // เมื่อส่ง Email สำเร็จแล้ว ให้แสดง dialog resetSuccessAlert
        resetSuccessAlert();
      } on FirebaseAuthException catch (e) {
        // หากมีปัญหา ไม่สามารถส่ง Email ได้ ให้ print error code ออกมา
        // เรียก resetFailAlert ซึ่งเป็น dialog แจ้งเตือนบนหน้าจอ
        print(e.code);
        resetFailAlert(e.code);
      }
    }
  }

  void resetFailAlert(String message) {
    // dialog แสดงบนหน้าจอเมื่อ ส่ง Email ไม่สำเร็จ
    // รับค่า error code
    String msg =
        message; // สร้างตัวแปร String ที่จะใช้สื่อสารกับผู้ใช้งานเป็นภาษาไทย
    // เช็ค error code ตามเงื่อนไขด้านล่าง เพื่อทำการอัพเดทค่าของ msg
    if (msg == 'user-not-found') {
      msg = 'ไม่มีบัญชีผู้ใช้นี้ในระบบ';
    }
    showDialog(
      // รายละเอียดของตัว dialog
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
    // dialog เมื่อส่ง Email สำเร็จ
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
    // ปุ่มกดย้อนกลับไปหน้าก่อนหน้า
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
    // header แสดงตัวหนังสือ
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
    double height =
        MediaQuery.of(context).size.height; // height เก็บค่าความสูงจอ
    return Scaffold(
      backgroundColor: Colors.yellow.shade50, // background จอสี yellow shade50
      body: Form(
        // ใช้ Form เพื่อเรียกใช้ _formKey สำหรับ validate ข้อมูล
        key: _formKey,
        child: ListView(children: [
          // แสดง listview คือชุด Widget ต่อๆกันตามด้านล่าง
          backButton(), // ตัวแรกเป็น backButton สำหรับกดย้อนกลับ
          header(), // ถัดมาเป็น header แสดงหัวข้อของหน้า
          Padding(
            // กำหนดระยะขอบจากหน้าจอ
            padding:
                EdgeInsets.symmetric(horizontal: 30.0, vertical: height / 4),
            child: Column(
              // Column ใช้แสดง content ต่างๆ
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // แสดงข้อความสื่อวารกับผู้ใช้
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
                  // validate ข้อมูลใน TextFormField
                  validator: (String value) {
                    if ((value.contains('@')) && (value.contains('.'))) {
                      return null;
                    } else {
                      return "กรุณากรอกอีเมลล์บัญชีผู้ใช้ของท่านให้ถูกต้อง";
                    }
                  },
                  onSaved: (newEmail) {
                    // validate ผ่าน ให้ save ข้อมูลลง _email
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
                  // ปุ่ม ส่งอีเมลล์
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade400,
                    onPrimary: Colors.black,
                  ),
                  child: Text('ส่งอีเมลล์'),
                  onPressed: () {
                    // เมื่อถูกกด ให้เรียกใช้ฟังก์ชัน _passwordReset()
                    _passwordReset();
                    // print ค่า _email ใน console
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
