import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  double screenWidth;
  double screenHeight;
  String username, email, password;
  bool redEyeStatus = true;

  Future<void> setupAccount() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      firebaseAuth.currentUser.updateProfile(displayName: username);

      Navigator.pushNamedAndRemoveUntil(
          context, '/home_signedin', (route) => false);
    } catch (e) {
      print("cannot updateProfile");
      registerFailAlert("ไม่สามารถสร้างบัญชีได้");
    }
  }

  void registerSuccessAlert() {
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
              "สร้างบัญชีใหม่สำเร็จ",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(
              "คุณสามารถเข้าสู่ระบบด้วยบัญชีนี้ได้ กด OK เพื่อไปยังหน้าหลัก"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                setupAccount();
              },
            )
          ],
        );
      },
    );
  }

  void registerFailAlert(String message) {
    String msg;
    if (message == 'email-already-in-use') {
      msg = 'อีเมลล์นี้มีผู้ใช้งานแล้ว';
    } else if (message == 'weak-password') {
      msg = 'รหัสผ่านต้องมีความยาวไม่ต่ำกว่า 6 ตัวอักษร';
    } else {
      msg = message;
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
              "พบปัญหาบางอย่าง ไม่สามารถสร้างบัญชีได้",
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
        "สร้างบัญชีใหม่",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.blue.shade900),
      ),
    );
  }

  Container buildUsername() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "ชื่อผู้ใช้งาน:",
          hintStyle: TextStyle(color: Colors.blue.shade900),
          helperText: "กรุณากรอกชื่อผู้ใช้งาน",
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
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "กรุณากรอกชื่อผู้ใช้ลงในช่องว่าง";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          username = value.trim();
        },
      ),
    );
  }

  Container buildEmail() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "ที่อยู่อีเมลล์:",
          hintStyle: TextStyle(color: Colors.blue.shade900),
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
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextFormField(
        obscureText: redEyeStatus,
        decoration: InputDecoration(
          hintText: "รหัสผ่าน:",
          hintStyle: TextStyle(color: Colors.blue.shade900),
          helperText: "กรุณากรอกรหัสผ่านความยาวไม่ต่ำกว่า 6 ตัวอักษร",
          helperStyle: TextStyle(
            color: Colors.blue.shade900,
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
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
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
    return Container(
      margin: EdgeInsets.only(top: 32),
      width: screenWidth * 0.8,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            print("username = $username, password = $password, email = $email");
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

  Future<void> registerFirebase() async {
    await Firebase.initializeApp().then((value) async {
      print("Register Firebase Initialize Success.");
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        registerSuccessAlert();
      } on FirebaseAuthException catch (err) {
        String code = err.code;
        String message = err.message;
        print("ERROR : $message CODE: $code");
        registerFailAlert(code);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: CustomPaint(
          painter: GreenPainter(),
          child: Center(
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  backButton(),
                  header(),
                  SizedBox(
                    height: 20,
                  ),
                  buildUsername(),
                  SizedBox(
                    height: 20,
                  ),
                  buildPassword(),
                  SizedBox(
                    height: 20,
                  ),
                  buildEmail(),
                  SizedBox(
                    height: 40,
                  ),
                  buildSignUp(),
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
