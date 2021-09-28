import 'package:engineeronline/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// การ import ด้านบนในทุกๆไฟล์คือการเรียกใช้งาน library ที่จำเป็นในไฟล์นั้นๆ

String initialRoute = '/home'; // กำหนดค่า String เริ่มต้นสำหรับ page เริ่มต้น
// ดูเพิ่มเติมว่า '/home' หมายถึงหน้าไหนได้ในไฟล์ router.dart
Future<Null> main() async {
  // ฟังก์ชัน main เรียกใช้งาน Firebase เพื่อให้เข้าถึงฐานข้อมูลของแอปได้
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    print("Main Firebase Initialize Success");
    FirebaseAuth.instance.authStateChanges().listen((event) {
      // ใช้ FirebaseAuth ดูว่าค่า event เป็น null ไหม เพื่อเช็คว่ามีการ login ค้างไว้หรือเปล่า
      if (event != null) {
        // ถ้ามีค่าไม่เป็น null คือมีการ login ค้างไว้ ให้เปลี่ยนค่า initialRoute ใหม่
        print("already login");
        initialRoute = '/home_signedin';
      } else {
        // else หมายถึงกรณีอื่นๆที่ไม่เข้าเงื่อนไข if ด้านบน ซึ่งก็คือไม่มีการ login ค้างไว้
        // กรณีนี้ไม่จำเป็นต้องเปลี่ยนค่า initialRoute
        print("not login");
      }
      runApp(
          MyApp()); // สั่งรันแอปให้ทำงาน โดยเรียกใช้งาน MyApp() ซึ่งมีรายละเอียดด้านล่าง
    });
  });
}

class MyApp extends StatelessWidget {
  // MyApp() ที่ถูกเรียกใช้ใน main
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // กำหนดการ route ไปหน้าแรกตามค่า initialRoute ที่กำหนดไว้
      routes: routes,
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
