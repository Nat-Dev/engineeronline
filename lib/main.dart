import 'package:engineeronline/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String initialRoute = '/home';
Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    print("Main Firebase Initialize Success");
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        print("already login");
        initialRoute = '/home_signedin';
      } else {
        print("not login");
      }
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
