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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // @override
  // void initState() {
  //   super.initState();
  //   checkStatus();
  // }

  // Future<void> checkStatus() async {
  //   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //   User firebaseUser = await firebaseAuth.currentUser;
  //   if (firebaseUser != null) {
  //     print("already log in");
  //   } else {
  //     print("not log in");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() {
    return Drawer(
      child: Center(
        child: Text("login"),
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
                builder: (BuildContext context) => Architecture(
                  title: "งานสถาปัตยกรรม",
                ),
              );
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
