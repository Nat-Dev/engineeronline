import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  // สร้างตัวแปรสำหรับ instance ของ FirebaseAuth เพื่อใช้งาน FirebaseAuth
  final auth = FirebaseAuth.instance;
  // สร้างตัวแปร user เพื่อใช้งานเป็นตัวแทนของ current account
  User user;
  // สร้างตัวแปร timer เพื่อใช้นับเวลาในการเปลี่ยนหน้าเมื่อ verify email แล้ว
  Timer timer;

  @override
  void initState() {
    // initState คือการทำงานเกี่ยวกับ state ก่อนที่ method build จะถูกทำงาน
    user = auth.currentUser;
    // user เก็บค่า currentUser จาก auth ซึ่งเป็น instance ของ FirebaseAuth
    user.sendEmailVerification();
    // ส่ง Email Verification ไปยัง email ของ user
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      // ทำการเช็คทุกๆ 3 วินาที ว่า email verify แล้วหรือยัง
      // การเช็ค email verify ทำโดยการเรียกใช้ฟังก์ชัน checkEmailVerified() ที่เขียนไว้
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Scaffold ไม่มี appbar เริ่มที่ body เลย
        // body แสดงตัวหนังสือบอกให้ผู้ใช้ verify email ตามที่อยู่ email ของ user
        child: Text("Email has been sent to ${user.email} please verify"),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    // ทุกครั้งที่เรียกใช้งานต้องทำการ reload user ใหม่
    if (user.emailVerified) {
      // เช็คว่า email ของ user ได้ถูก verify หรือยัง
      timer.cancel(); // เมื่อถูก verify แล้วให้หยุด timer นับเวลา
      Navigator.pushNamedAndRemoveUntil(
          // เปลี่ยนไปหน้า '/home_signedin'
          context,
          '/home_signedin',
          (route) => false);
    }
  }
}
