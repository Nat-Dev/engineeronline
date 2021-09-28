import 'package:flutter/material.dart';

class GeneralTopics extends StatefulWidget {
  @override
  _GeneralTopicsState createState() => _GeneralTopicsState();
}

class _GeneralTopicsState extends State<GeneralTopics> {
  Container buildListview(String str) {
    // buildListview แสดงหัวข้อหลักของ "ความรู้วิศวกรรมในงานก่อสร้าง"
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        child: ListTile(
          onTap: () {
            // เมื่อถูกกด เช็คชื่อของ Card ที่ถูกกดแล้วให้วิ่งไปยังหน้านั้นๆ
            if (str == "คำศัพท์ภาษาอังกฤษทางวิศวกรรม") {
              Navigator.pushNamed(context, '/engineer_vocab');
            } else if (str == "งานโครงสร้าง") {
              Navigator.pushNamed(context, '/structure_work');
            } else if (str == "งานระบบ") {
              Navigator.pushNamed(context, '/system_work');
            } else if (str == "โซล่าเซลล์") {
              Navigator.pushNamed(context, '/solar_cell');
            }
          },
          title: Center(
            child: Text(
              str,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.5,
              ),
            ),
          ),
        ),
        color: Colors.amber.shade100,
      ),
      margin: EdgeInsets.all(4.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          // ตัวหนังสือบน appbar
          "ความรู้วิศวกรรมในงานก่อสร้าง",
          style: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: [
                    // สร้าง listview ตามข้อมูลด้านล่าง
                    buildListview("คำศัพท์ภาษาอังกฤษทางวิศวกรรม"),
                    buildListview("งานโครงสร้าง"),
                    buildListview("งานระบบ"),
                    buildListview("โซล่าเซลล์"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
