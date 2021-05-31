import 'package:engineeronline/screens/contents/contact.dart';
import 'package:engineeronline/screens/contents/contract.dart';
import 'package:engineeronline/screens/contents/general.dart';
import 'package:engineeronline/screens/contents/standard.dart';
import 'package:engineeronline/screens/contents/technique.dart';
import 'package:engineeronline/screens/contents/structure.dart';
import 'package:engineeronline/screens/contents/architecture.dart';
import 'package:engineeronline/screens/contents/system.dart';
import 'package:engineeronline/screens/contents/legislation.dart';
import 'package:engineeronline/screens/contents/materials.dart';
import 'package:engineeronline/screens/contents/codeofpractice.dart';
import 'package:engineeronline/screens/contents/ethics.dart';
import 'package:engineeronline/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    await Firebase.initializeApp().then((value) async {
      print("Home Firebase Initialize Success.");
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      User user = await firebaseAuth.currentUser;
      if (user != null) {
        print("already login");
      } else {
        print("not login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool login;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.09),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "วิศวกร EIT Online",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.yellowAccent,
              shadows: [
                Shadow(
                  offset: Offset(1.75, 1.75),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                )
              ],
            ),
          ),
          backgroundColor: Colors.red.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 64),
              child: Image.asset(
                'images/logo.png',
                width: 45,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              buildCard("ความรู้วิศวกรรมในงานก่อสร้าง"),
              buildCard("เทคนิคการก่อสร้าง"),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: [
                    buildGridview("งานโครงสร้าง"),
                    buildGridview("งานสถาปัตยกรรม"),
                    buildGridview("งานวิศวกรรมระบบ"),
                    buildGridview("กฏหมายเทศบัญญัติ"),
                    buildGridview("มาตรฐานการทำงาน"),
                    buildGridview("สัญญาการก่อสร้าง"),
                    buildGridview("วัสดุก่อสร้าง"),
                    buildGridview("Code of Practice"),
                    buildGridview("จรรยาบรรณ"),
                  ],
                ),
              ),
              buildCard("พบช่างและถามตอบ"),
            ],
          ),
        ),
      ),
      drawer: drawerHome(screenHeight, screenWidth),
      // drawer: login
      //     ? drawerLogin(screenHeight, screenWidth)
      //     : drawerHome(screenHeight, screenWidth),
    );
  }

  // Drawer showDrawer(bool login) {
  //   double screenHeight = MediaQuery.of(context).size.height;
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   if (login) {
  //     return drawerLogin(screenHeight, screenWidth);
  //   } else {
  //     return drawerHome(screenHeight, screenWidth);
  //   }
  // }

  Future<void> signOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Drawer drawerHome(double screenHeight, double screenWidth) {
    double height = screenHeight;
    double width = screenWidth;
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.5,
            ),
            child: Container(
              width: width * 0.7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue.shade900),
                child: Text(
                  "เข้าสู่ระบบ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
              ),
            ),
          ),
          Container(
            width: width * 0.7,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black)),
              child: Text(
                "สร้างบัญชีใหม่",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue.shade900),
              ),
              onPressed: () {
                MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    builder: (BuildContext context) => Register());
                Navigator.of(context).push(materialPageRoute);
              },
            ),
          ),
        ],
      ),
    );
  }

  Drawer drawerLogin(double screenHeight, double screenWidth) {
    double height = screenHeight;
    double width = screenWidth;
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.5,
            ),
            child: Container(
              width: width * 0.7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue.shade900),
                child: Text(
                  "ALREADY LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
              ),
            ),
          ),
          Container(
            width: width * 0.7,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black)),
              child: Text(
                "Sign Out",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue.shade900),
              ),
              onPressed: () {
                signOut();
              },
            ),
          ),
        ],
      ),
    );
  }

  Card buildCard(String str) {
    return Card(
      color: Colors.blue.shade900,
      margin: EdgeInsets.all(12.5),
      child: ListTile(
        onTap: () {
          if (str == "ความรู้วิศวกรรมในงานก่อสร้าง") {
            MaterialPageRoute materialPageRoute =
                MaterialPageRoute(builder: (BuildContext context) => General());
            Navigator.of(context).push(materialPageRoute);
          } else if (str == "เทคนิคการก่อสร้าง") {
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
                builder: (BuildContext context) => Technique());
            Navigator.of(context).push(materialPageRoute);
          } else if (str == "พบช่างและถามตอบ") {
            MaterialPageRoute materialPageRoute =
                MaterialPageRoute(builder: (BuildContext context) => Contact());
            Navigator.of(context).push(materialPageRoute);
          }
        },
        title: Center(
          child: Text(
            str,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.yellowAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14.5,
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
      ),
    );
  }

  Container buildGridview(String str) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        child: ListTile(
          onTap: () {
            if (str == "งานโครงสร้าง") {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Structure());
              Navigator.of(context).push(materialPageRoute);
            } else if (str == "งานสถาปัตยกรรม") {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Architecture());
              Navigator.of(context).push(materialPageRoute);
            } else if (str == "งานวิศวกรรมระบบ") {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => System());
              Navigator.of(context).push(materialPageRoute);
            } else if (str == "กฏหมายเทศบัญญัติ") {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Legislation());
              Navigator.of(context).push(materialPageRoute);
            } else if (str == "มาตรฐานการทำงาน") {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Standard());
              Navigator.of(context).push(materialPageRoute);
            } else if (str == "สัญญาการก่อสร้าง") {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Contract());
              Navigator.of(context).push(materialPageRoute);
            } else if (str == "วัสดุก่อสร้าง") {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Materials());
              Navigator.of(context).push(materialPageRoute);
            } else if (str == "Code of Practice") {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => CodeOfPractice());
              Navigator.of(context).push(materialPageRoute);
            } else if (str == "จรรยาบรรณ") {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Ethics());
              Navigator.of(context).push(materialPageRoute);
            }
          },
          title: Center(
            child: Text(
              str,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.yellowAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14.5,
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
        ),
        color: Colors.blue.shade900,
      ),
      margin: EdgeInsets.all(4.0),
    );
  }
}
