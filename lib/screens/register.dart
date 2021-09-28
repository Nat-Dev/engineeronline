import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  // กำหนด formKey สำหรับใช้ validate ข้อมูลที่ผู้ใช้กรอก
  final formKey = GlobalKey<FormState>();

  // กำหนดตัวแปรสำหรับเก็บค่าความสูงและความกว้างหน้าจอ
  double screenWidth;
  double screenHeight;

  // กำหนดตัวแปรต่างๆที่จะใช้งานคล้ายกับหน้า '/authen'
  String username, email, password;
  bool redEyeStatusPassword = true;

  void registerFailAlert(String message) {
    // dialog แสดงบนหน้าจอเมื่อ register ไม่สำเร็จ
    // รับค่า error code (String message)
    String msg; // สร้างตัวแปร String ที่จะใช้สื่อสารกับผู้ใช้งานเป็นภาษาไทย
    // เช็ค error code ตามเงื่อนไขด้านล่าง เพื่อทำการอัพเดทค่าของ msg
    if (message == 'email-already-in-use') {
      msg = 'อีเมลล์นี้มีผู้ใช้งานแล้ว';
    } else if (message == 'weak-password') {
      msg = 'รหัสผ่านต้องมีความยาวไม่ต่ำกว่า 6 ตัวอักษร';
    } else {
      msg = message;
    }
    showDialog(
      // แสดง dialog บนหน้าจอ
      barrierDismissible: true, // สามารถแตะกรอบนอก dialog เพื่อปิด dialog ได้
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
              "พบปัญหาบางอย่าง ไม่สามารถสร้างบัญชีได้",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(
              msg), // รายละเอียดเกี่ยวกับการเข้าสู่ระบบไม่สำเร็จจาก message
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

  Future<void> registerFirebase() async {
    // ฟังก์ชันสำหรับ register account กับ Firebase
    await Firebase.initializeApp().then((value) async {
      print("Register Firebase Initialize Success.");
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      // สร้าง instance ของ FirebaseAuth เพื่อใช้งานในการสร้าง account
      try {
        // สร้าง account ด้วย email, password
        await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          // print ข้อความเมื่อสร้างสำเร็จ
          print("Register Successfully");
          // updateProfile ของ user แล้วไปยังหน้า '/verify'
          await value.user.updateProfile(displayName: username).then((value) =>
              Navigator.pushNamedAndRemoveUntil(
                  context, '/verify', (route) => false));
        });
      } on FirebaseAuthException catch (err) {
        // หากมีปัญหา ไม่สามารถสร้างบัญชีได้ ให้ print error code ออกมา
        // เรียก registerFailAlert ซึ่งเป็น dialog แจ้งเตือนบนหน้าจอ
        String code = err.code;
        String message = err.message;
        print("ERROR : $message CODE: $code");
        registerFailAlert(code);
      }
    });
  }

  Widget backButton() {
    // ปุ่มย้อนกลับไปยังหน้าก่อนหน้า
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
    // header แสดงหัวข้อ
    return Align(
      alignment: Alignment(0, 0),
      child: Text(
        "การสมัครสมาชิก",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.blue.shade900),
      ),
    );
  }

  Container buildUsername() {
    // ช่องกรอก username
    return Container(
      margin: EdgeInsets.only(top: 64),
      width: screenWidth * 0.8,
      child: TextFormField(
        // ใช้ TextFormField เพื่อ validate ข้อมูบ
        decoration: InputDecoration(
          hintText: "ชื่อผู้ใช้:",
          hintStyle: TextStyle(color: Colors.blue.shade900),
          errorStyle: TextStyle(color: Colors.black),
          helperText: "กรุณากรอกชื่อผู้ใช้",
          helperStyle: TextStyle(
            color: Colors.blue.shade900,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon: Icon(Icons.perm_identity),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        validator: (String value) {
          // validate ว่าค่าในช่องนี้ห้ามเป็นค่าว่าง หรือก็คือผู้ใช้ต้องกรอกค่าในช่องนี้
          if (value.isEmpty) {
            return "กรุณากรอกชื่อผู้ใช้ลงในช่องว่าง";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          // validate สำเร็จ save ค่า
          username = value.trim();
        },
      ),
    );
  }

  Container buildEmail() {
    // ส่วนของการกรอก Email เหมือนกับหน้า '/authen'
    return Container(
      margin: EdgeInsets.only(top: 32),
      width: screenWidth * 0.8,
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "อีเมลล์:",
          hintStyle: TextStyle(color: Colors.blue.shade900),
          errorStyle: TextStyle(color: Colors.black),
          helperText: "กรุณากรอกที่อยู่อีเมลล์",
          helperStyle: TextStyle(
            color: Colors.blue.shade900,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon: Icon(Icons.email_outlined),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        validator: (String value) {
          if (!(value.contains('@') && value.contains('.'))) {
            return "กรุณากรอกที่อยู่อีเมลล์ของท่าน";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          email = value.trim();
        },
      ),
    );
  }

  Container buildPassword() {
    // ส่วนของการกรอก Password เหมือนกับหน้า '/authen'
    return Container(
      margin: EdgeInsets.only(top: 32),
      width: screenWidth * 0.8,
      child: TextFormField(
        obscureText: redEyeStatusPassword,
        decoration: InputDecoration(
          hintText: "รหัสผ่าน:",
          hintStyle: TextStyle(color: Colors.blue.shade900),
          errorStyle: TextStyle(color: Colors.black),
          helperText: "กรุณากรอกรหัสผ่าน",
          helperStyle: TextStyle(
            color: Colors.blue.shade900,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: IconButton(
              icon: redEyeStatusPassword
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                setState(() {
                  redEyeStatusPassword = !redEyeStatusPassword;
                });
              }),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        validator: (String value) {
          if (value.length < 6) {
            return "กรุณากรอกรหัสผ่านความยาวไม่ต่ำกว่า 6 ตัวอักษร";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          password = value.trim();
        },
      ),
    );
  }

  Container buildSignUp() {
    // ปุ่ม sign up
    return Container(
      margin: EdgeInsets.only(top: 32),
      width: screenWidth * 0.8,
      child: ElevatedButton(
        onPressed: () {
          // ฟังก์ชัน onPressed จะทำงานเมื่อปุ่มถูกกด
          if (formKey.currentState.validate()) {
            // เช็คว่า form ที่ validate ทั้งหมดถูกต้องไหม
            formKey.currentState.save();
            print("username = $username, password = $password, email = $email");
            // เรียกใช้งาน registerFirebase
            registerFirebase();
          }
        },
        child: Text(
          "สร้างบัญชี",
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // Scaffold ไม่มี appbar เริ่มที่ body เลย
      body: SafeArea(
        child: CustomPaint(
          // CustonPaint ใช้เพื่อวาดฉากหลังของหน้าจอ
          painter:
              GreenPainter(), // เรียกใช้การวาด BluePainter ที่เขียนไว้ล่างสุดของไฟล์
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
                    // SizedBox ใช้สำหรับเว้นระยะห่าง ในที่นี้คือเว้นความสูง 20 px
                    height: 20,
                  ),
                  buildUsername(), // ช่องกรอก username
                  SizedBox(
                    // SizedBox ใช้สำหรับเว้นระยะห่าง ในที่นี้คือเว้นความสูง 20 px
                    height: 20,
                  ),
                  buildEmail(), // ช่องกรอก email
                  SizedBox(
                    // SizedBox ใช้สำหรับเว้นระยะห่าง ในที่นี้คือเว้นความสูง 20 px
                    height: 20,
                  ),
                  buildPassword(), // ช่องกรอก password
                  SizedBox(
                    // SizedBox ใช้สำหรับเว้นระยะห่าง ในที่นี้คือเว้นความสูง 40 px
                    height: 40,
                  ),
                  buildSignUp(), // ปุ่ม sign up
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GreenPainter extends CustomPainter {
  // GreenPainter ใช้วาดฉากหลังของหน้าจอ ก็คือรูปครึ่งวงกลมสีเขียวซึ่งเป็นพื้นหลังของหน้านี้
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
    paint.color = Colors.green.shade200;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
