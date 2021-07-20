import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeSignedIn extends StatefulWidget {
  @override
  _HomeSignedInState createState() => _HomeSignedInState();
}

class _HomeSignedInState extends State<HomeSignedIn> {
  String username, email;
  @override
  void initState() {
    super.initState();
    findNameAndEmail();
  }

  Future<Null> findNameAndEmail() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          username = event.displayName;
          email = event.email;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.09),
        child: AppBar(
          centerTitle: true,
          title: AutoSizeText(
            "วิศวกร EIT Online",
            textAlign: TextAlign.center,
            maxLines: 1,
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
      drawer: drawerLogin(),
    );
  }

  Future<void> signOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    });
  }

  Drawer drawerLogin() {
    return Drawer(
      child: Stack(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue.shade900, Colors.grey.shade400])),
            accountName: Text(username == null ? 'Username' : username),
            accountEmail: Text(email == null ? 'Email' : email),
            currentAccountPicture: Image.asset('images/logo.png'),
          ),
          buildSignOut(),
        ],
      ),
    );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          tileColor: Colors.blueGrey.shade800,
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 26.0,
          ),
          title: Text(
            "ออกจากระบบ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          subtitle: Text(
            "ออกจากระบบสำหรับบัญชีนี้",
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
          onTap: () {
            signOut();
          },
        ),
      ],
    );
  }

  Card buildCard(String str) {
    return Card(
      color: Colors.blue.shade900,
      margin: EdgeInsets.all(12.5),
      child: ListTile(
        onTap: () {
          if (str == "ความรู้วิศวกรรมในงานก่อสร้าง") {
            Navigator.pushNamed(context, '/general');
          } else if (str == "เทคนิคการก่อสร้าง") {
            Navigator.pushNamed(context, '/technique_topics');
          } else if (str == "พบช่างและถามตอบ") {
            Navigator.pushNamed(context, '/contact');
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
              Navigator.pushNamed(context, '/structure');
            } else if (str == "งานสถาปัตยกรรม") {
              Navigator.pushNamed(context, '/architecture');
            } else if (str == "งานวิศวกรรมระบบ") {
              Navigator.pushNamed(context, '/system');
            } else if (str == "กฏหมายเทศบัญญัติ") {
              Navigator.pushNamed(context, '/legislation');
            } else if (str == "มาตรฐานการทำงาน") {
              Navigator.pushNamed(context, '/standard');
            } else if (str == "สัญญาการก่อสร้าง") {
              Navigator.pushNamed(context, '/contract');
            } else if (str == "วัสดุก่อสร้าง") {
              Navigator.pushNamed(context, '/materials');
            } else if (str == "Code of Practice") {
              Navigator.pushNamed(context, '/code_of_practice');
            } else if (str == "จรรยาบรรณ") {
              Navigator.pushNamed(context, '/ethics');
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
