import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  String email, password;
  bool redEyeStatus = true;

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
        "การเข้าสู่ระบบ",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.green.shade900),
      ),
    );
  }

  Container buildEmail() {
    return Container(
      margin: EdgeInsets.only(top: 80),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "ที่อยู่อีเมลล์:",
          hintStyle: TextStyle(color: Colors.black),
          helperText: "กรุณากรอกที่อยู่อีเมลล์",
          helperStyle: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon: Icon(Icons.email_outlined),
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
          if (!(value.contains('@') && value.contains('.'))) {
            return "กรุณากรอกที่อยู่อีเมลล์ลงในช่องว่าง";
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
    return Container(
      child: TextFormField(
        obscureText: redEyeStatus,
        decoration: InputDecoration(
          hintText: "รหัสผ่าน:",
          hintStyle: TextStyle(color: Colors.black),
          helperText: "กรุณากรอกรหัสผ่าน",
          helperStyle: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: IconButton(
              icon: redEyeStatus
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                setState(() {
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
          if (value.length < 6) {
            return "กรุณากรอกรหัสของบัญชีนี้";
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

  Container buildSignIn() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password)
                  .then((value) {
                formKey.currentState.reset();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home_signedin', (route) => false);
              });
            } on FirebaseException catch (e) {
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
          Navigator.pushNamed(context, '/forgot_password');
        },
      ),
    );
  }

  void loginFailAlert(String ecode) {
    String message;
    if (ecode == 'user-not-found') {
      message = 'ไม่พบบัญชีผู้ใช้นี้ในระบบ';
    } else if (ecode == 'wrong-password') {
      message = 'รหัสผ่านไม่ถูกต้อง';
    } else {
      message = ecode;
    }
    showDialog(
      barrierDismissible: false,
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
              "ไม่สามารถเข้าสู่ระบบได้",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomPaint(
          painter: BluePainter(),
          child: Center(
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  backButton(),
                  header(),
                  SizedBox(
                    height: 40,
                  ),
                  buildEmail(),
                  SizedBox(
                    height: 80,
                  ),
                  buildPassword(),
                  SizedBox(
                    height: 40,
                  ),
                  buildSignIn(),
                  SizedBox(
                    height: 10,
                  ),
                  buildForgotPassword()
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
