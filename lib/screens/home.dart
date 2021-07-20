import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
      drawer: drawerHome(screenHeight, screenWidth),
    );
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
          ),
          Container(
            width: width * 0.7,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue.shade900),
              child: Text(
                "เข้าสู่ระบบ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/authen');
              },
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
                Navigator.pushNamed(context, '/register');
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
