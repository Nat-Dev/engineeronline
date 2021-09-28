import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // กำหนด formKey สำหรับใช้ validate ข้อมูลที่ผู้ใช้กรอก
  final formKey = GlobalKey<FormState>();
  // final Future<FirebaseApp> firebase = Firebase.initializeApp();
  // กำหนดตัวแปร String สำหรับเก็บค่า email, password
  String email, password;
  // กำหนดตัวแปร boolean redEyeStatus สำหรับใช้เปิดปิดการมองเห็นรหัสผ่าน (password)
  bool redEyeStatus = true;

  Widget backButton() {
    // ปุ่มสำหรับย้อนกลับไปหน้าก่อนหน้า
    return Align(
      // กำหนดลักษณะปุ่ม
      alignment: Alignment(-1, 0),
      child: IconButton(
        icon: Icon(
          Icons.navigate_before,
          size: 36.0,
          color: Colors.blue.shade700,
        ),
        onPressed: () {
          // เมื่อถูกกด ให้ทำการ pop หรือถอดหน้านี้ออก ซึ่งหมายถึงกลับไปยังหน้าก่อนหน้านี้
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget header() {
    // ส่วนหัวของหน้า (ไม่ใช่ appbar)
    return Align(
      alignment: Alignment(0, 0),
      child: Text(
        // กำหนดตัวหนังสือ
        "การเข้าสู่ระบบ",
        style: TextStyle(
            // กำหนดลักษณะตัวหนังสือ ตัวหนา, ขนาด, สี
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.green.shade900),
      ),
    );
  }

  Container buildEmail() {
    // ส่วนของการกรอก Email
    return Container(
      margin: EdgeInsets.only(top: 80),
      child: TextFormField(
        // TextFormField ใช้สำหรับกรอกค่า ในที่นี้คือ Email
        keyboardType: TextInputType.emailAddress, // keyboard สำหรับพิมพ์ Email
        decoration: InputDecoration(
          hintText: "ที่อยู่อีเมลล์:", // hint บอกว่าให้กรอกอะไร
          hintStyle: TextStyle(color: Colors.black), // สีตัวหนังสือ hint
          helperText:
              "กรุณากรอกที่อยู่อีเมลล์", // คำอธิบายด้านล่างพื้นที่กรอก Email
          helperStyle: TextStyle(
            // เพิ่มลักษณะให้คำอธิบาย สี, ตัวเอียง, ขนาด
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon:
              Icon(Icons.email_outlined), // เพิ่มไอคอนรูป Email ด้านหน้า
          enabledBorder: OutlineInputBorder(
            // กำหนดลักษณะขอบของช่องกรอกข้อมูล
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            // กำหนดลักษณะขอบของช่องกรอกข้อมูล เมื่อถูกโฟกัส (กำลังถูกพิมพ์ข้อมูล)
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (String value) {
          // การ validate หรือการตรวจสอบความถูกต้อง โดยรับค่า value เข้ามาตรวจสอบ
          // ค่า value คือค่าที่ผู้ใช้กรอก ในที่นี้คือตัว Email
          // เช็คว่า value ประกอบด้วย @ และ . หรือไม่ เพราะเป็นส่วนประกอบของ Email
          if (!(value.contains('@') && value.contains('.'))) {
            // ถ้า value ไม่มี @ หรือไม่มี . ให้ทำการเตือนด้วยข้อความที่ return
            return "กรุณากรอกที่อยู่อีเมลล์ลงในช่องว่าง";
          } else {
            // ถ้า value มี @ และ . แล้ว ให้ คืนค่า null คือไม่ทำการเตือนอะไรและให้ผ่าน
            return null;
          }
        },
        onSaved: (String value) {
          // เมื่อ validate สำเร็จ ให้ทำการ save ข้อมูลของ value ลงในตัวแปร email
          // trim() คือการตัดช่องว่างด้านหลังออก กรณีกรอกอีเมล์แล้วติด space ต่อท้าย
          email = value.trim();
        },
      ),
    );
  }

  Container buildPassword() {
    // ส่วนของการกรอก Password
    return Container(
      child: TextFormField(
        // TextFormField ใช้สำหรับกรอกค่า ในที่นี้คือ Password
        obscureText: redEyeStatus,
        decoration: InputDecoration(
          hintText: "รหัสผ่าน:", // hint บอกว่าให้กรอกอะไร
          hintStyle: TextStyle(color: Colors.black), // สีตัวหนังสือ hint
          helperText: "กรุณากรอกรหัสผ่าน", // คำอธิบายด้านล่างพื้นที่กรอก Email
          helperStyle: TextStyle(
            // เพิ่มลักษณะให้คำอธิบาย สี, ตัวเอียง, ขนาด
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon:
              Icon(Icons.lock_outline), // เพิ่มไอคอนรูป แม่กุญแจ ด้านหน้า
          suffixIcon: IconButton(
              // เพิ่มไอคอนรูป RedEye สำหรับเปิดปิดการแสดง Password
              // ไอคอนสลับไปมาระหว่าง RedEye กับ RedEye outlined เมื่อถูกคลิก
              icon: redEyeStatus
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                // เมื่อถูกคลิกให้สลับค่า redEyeStatus จากค่าปัจจุบัน
                setState(() {
                  // การสลับค่าต้องทำใน setState เพื่อสร้าง state ใหม่แล้วแสดงผลบนจอ
                  redEyeStatus = !redEyeStatus;
                });
              }),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (String value) {
          // การ validate หรือการตรวจสอบความถูกต้อง โดยรับค่า value เข้ามาตรวจสอบ
          // ค่า value คือค่าที่ผู้ใช้กรอก ในที่นี้คือตัว Password
          // เช็คว่า value ต้องมีความยาวไม่น้อยกว่า 6 ตัวอักษร
          if (value.length < 6) {
            return "กรุณากรอกรหัสของบัญชีนี้";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          // เมื่อ validate สำเร็จ ให้ทำการ save ข้อมูลของ value ลงในตัวแปร password
          // trim() คือการตัดช่องว่างด้านหลังออก กรณีกรอกอีเมล์แล้วติด space ต่อท้าย
          password = value.trim();
        },
      ),
    );
  }

  Container buildSignIn() {
    // ปุ่ม Sign In
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: ElevatedButton(
        onPressed: () async {
          // ฟังก์ชัน onPressed จะทำงานเมื่อปุ่มถูกกด
          if (formKey.currentState.validate()) {
            // เช็คว่า form ที่ validate ทั้งหมดถูกต้องไหม
            formKey.currentState.save();
            try {
              // sign in ด้วย email และ password เข้าสู่ Firebase
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password)
                  .then((value) {
                // หลังจาก sign in สำเร็จ ให้ reset ค่า formKey
                // จากนั้นเปลี่ยนหน้าไปสู่หน้า '/home_signedin'
                formKey.currentState.reset();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home_signedin', (route) => false);
              });
            } on FirebaseException catch (e) {
              // หากมีปัญหา ไม่สามารถเข้าสู่ระบบได้ ให้ print error code ออกมา
              // เรียก loginFailAlert ซึ่งเป็น dialog แจ้งเตือนบนหน้าจอ
              print(e.code);
              loginFailAlert(e.code);
            }
          }
        },
        child: Text(
          "เข้าสู่ระบบ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.greenAccent.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }

  Align buildForgotPassword() {
    // ปุ่ม ForgotPassword
    return Align(
      alignment: Alignment(1, 1),
      child: TextButton(
        child: Text(
          "ลืมรหัสผ่าน?",
          style: TextStyle(
            color: Colors.purple.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 15.5,
          ),
        ),
        onPressed: () {
          // เมื่อถูกกดจะไปยังหน้า '/forgot_password'
          Navigator.pushNamed(context, '/forgot_password');
        },
      ),
    );
  }

  void loginFailAlert(String ecode) {
    // dialog แสดงบนหน้าจอเมื่อ login ไม่สำเร็จ
    // รับค่า error code
    String message; // สร้างตัวแปร String ที่จะใช้สื่อสารกับผู้ใช้งานเป็นภาษาไทย
    // เช็ค error code ตามเงื่อนไขด้านล่าง เพื่อทำการอัพเดทค่าของ message
    if (ecode == 'user-not-found') {
      message = 'ไม่พบบัญชีผู้ใช้นี้ในระบบ';
    } else if (ecode == 'wrong-password') {
      message = 'รหัสผ่านไม่ถูกต้อง';
    } else {
      message = ecode;
    }
    showDialog(
      // แสดง dialog บนหน้าจอ
      barrierDismissible: false, // ไม่สามารถแตะกรอบนอก dialog เพื่อปิดได้
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              // ใส่ Icon บนหัว dialog
              Icons.assignment_late,
              color: Colors.red,
              size: 48.0,
            ),
            title: Text(
              // ตัวหนังสือบน dialog
              "ไม่สามารถเข้าสู่ระบบได้",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(
              message), // รายละเอียดเกี่ยวกับการเข้าสู่ระบบไม่สำเร็จจาก message
          actions: <Widget>[
            TextButton(
              // ปุ่ม OK ของ dialog
              child: Text("OK"),
              onPressed: () {
                // เมื่อถูกกดจะ pop ตัว dialog ออก หรือปิด dialog
                Navigator.of(context).pop();
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
      // Scaffold ไม่มี appbar เริ่มที่ body เลย
      body: SafeArea(
        child: CustomPaint(
          // CustonPaint ใช้เพื่อวาดฉากหลังของหน้าจอ
          painter:
              BluePainter(), // เรียกใช้การวาด BluePainter ที่เขียนไว้ล่างสุดของไฟล์
          child: Center(
            // ให้ content ต่างๆอยู่ตรงกลางจอ
            child: Form(
              // ใส่ Form เพื่อใช้ formKey ในการ validate ข้อมูล
              key: formKey,
              child: ListView(
                children: [
                  backButton(), // ปุ่มย้อนกลับไปหน้าก่อนหน้า
                  header(), // ตัว header แสดงหัวข้อ
                  SizedBox(
                    // SizedBox ใช้สำหรับเว้นระยะห่าง ในที่นี้คือเว้นความสูง 40 px
                    height: 40,
                  ),
                  buildEmail(), // ช่องกรอก email
                  SizedBox(
                    // SizedBox ใช้สำหรับเว้นระยะห่าง ในที่นี้คือเว้นความสูง 80 px
                    height: 80,
                  ),
                  buildPassword(), // ช่องกรอก password
                  SizedBox(
                    // SizedBox ใช้สำหรับเว้นระยะห่าง ในที่นี้คือเว้นความสูง 40 px
                    height: 40,
                  ),
                  buildSignIn(), // ปุ่ม sign in
                  SizedBox(
                    // SizedBox ใช้สำหรับเว้นระยะห่าง ในที่นี้คือเว้นความสูง 10 px
                    height: 10,
                  ),
                  buildForgotPassword() // ปุ่ม forgot password
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BluePainter extends CustomPainter {
  // BluePainter ใช้วาดฉากหลังของหน้าจอ ก็คือรูปครึ่งวงกลมสีฟ้าซึ่งเป็นพื้นหลังของหน้านี้
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.grey.shade200;
    canvas.drawPath(mainBackground, paint);
    Path ovalPath = Path();
    ovalPath.moveTo(0, height * 0.2);
    ovalPath.quadraticBezierTo(
        width * 0.45, height * 0.25, width * 0.51, height * 0.5);
    ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width * 0.1, height);
    ovalPath.lineTo(0, height);
    ovalPath.close();
    paint.color = Colors.blue.shade100;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
