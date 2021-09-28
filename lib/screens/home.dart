import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  // StatefulWidget คือสามารถเปลี่ยนแปลงค่าต่างๆในหน้านั้นได้ผ่าน state
  @override
  _HomeState createState() => _HomeState(); // สร้าง state _HomeState
}

class _HomeState extends State<Home> {
  @override
  // method build จะเป็นส่วนที่แสดงว่าหน้านั้นๆมีอะไรบ้าง
  Widget build(BuildContext context) {
    // เก็บค่าขนาดความสูงของหน้าจอและความกว้างของหน้าจอ
    double screenHeight = MediaQuery.of(context).size.height; // ความสูงหน้าจอ
    double screenWidth = MediaQuery.of(context).size.width; // ความกว้างหน้าจอ
    return Scaffold(
      // build จะต้อง return Widget เสมอ ในที่นี้เป็น Scaffold
      // Scaffold ประกอบไปด้วย appbar คือส่วนหัวด้านบน และ body คือ contents ด้านล่าง
      appBar: PreferredSize(
        // การกำหนดขนาด appbar ให้ Scaffold
        // กำหนดความสูงของ appbar เป็น ความสูงของหน้าจอ คูณ 0.09
        preferredSize: Size.fromHeight(screenHeight * 0.09),
        child: AppBar(
          // การสร้าง appbar ให้ Scaffold
          centerTitle: true, // ตัวหนังสือใน appbar อยู่ตรงกลาง
          title: AutoSizeText(
            // กำหนดตัวหนังสือใน appbar
            "วิศวกร EIT Online",
            textAlign: TextAlign.center,
            maxLines:
                1, // ตัวหนังสือของ appbar มีได้สูงสุดแค่ 1 บรรทัด กรณีจอเล็ก
            style: TextStyle(
              // กำหนด style ของ ตัวหนังสือใน appbar
              fontWeight: FontWeight.bold, // กำหนดให้ใช้ตัวหนา
              fontSize: 20, // กำหนด font 20 เป็นค่า default
              color: Colors.yellowAccent, // กำหนดสี yellowAccent
              shadows: [
                Shadow(
                  // กำหนดเงาให้ตัวหนังสือ
                  offset: Offset(1.75, 1.75),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                )
              ],
            ),
          ),
          backgroundColor: Colors.red.shade800, // กำหนดสีพื้นหลังของ appbar
          shape: RoundedRectangleBorder(
            // กำหนดรูปทรงของ appbar
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          actions: [
            // actions คือส่วนที่อยู่ต่อจาก title หรือตัวหนังสือใน appbar
            Padding(
              // กำหนดให้เป็นรูป logo.png ใน images ของ project
              padding: const EdgeInsets.only(right: 64), // กำหนดระยะจากขวาสุด
              child: Image.asset(
                'images/logo.png',
                width: 45, // กำหนดขนาดรูป
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        // body คือส่วนของ contents ต่างๆในหน้านั้นๆ
        child: Container(
          child: Column(
            children: [
              // buildCard คือปุ่มยาว buildGridview คือปุ่มสั้น
              // ดูโครงสร้างและการทำงานของปุ่มเหล่านี้ได้ในฟังก์ชัน buildCard, builGridview
              // ฟังก์ชันเหล่านี้ถูกเขียนไว้ในไฟล์นี้
              buildCard(
                  "ความรู้วิศวกรรมในงานก่อสร้าง"), // ปุ่ม ความรู้วิศวกรรมในงานก่อสร้าง
              buildCard("เทคนิคการก่อสร้าง"), // ปุ่ม เทคนิคการก่อสร้าง
              Expanded(
                // กำหนดส่วนต่อเป็น Gridview ที่มี 3 ปุ่มต่อ 1 แถว
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: [
                    buildGridview("งานโครงสร้าง"), // ปุ่ม งานโครงสร้าง
                    buildGridview("งานสถาปัตยกรรม"), // ปุ่ม งานสถาปัตยกรรม
                    buildGridview("งานวิศวกรรมระบบ"), // ปุ่ม งานวิศวกรรมระบบ
                    buildGridview("กฏหมายเทศบัญญัติ"), // ปุ่ม กฏหมายเทศบัญญัติ
                    buildGridview("มาตรฐานการทำงาน"), // ปุ่ม มาตรฐานการทำงาน
                    buildGridview("สัญญาการก่อสร้าง"), // ปุ่ม สัญญาการก่อสร้าง
                    buildGridview("วัสดุก่อสร้าง"), // ปุ่ม วัสดุก่อสร้าง
                    buildGridview("Code of Practice"), // ปุ่ม Code of Practice
                    buildGridview("จรรยาบรรณ"), // ปุ่ม จรรยาบรรณ
                  ],
                ),
                // สิ้นสุดส่วนของ Gridview หรือ ปุ่มสั้น
              ),
              buildCard("พบช่างและถามตอบ"), // ปุ่ม พบช่างและถามตอบ
            ],
          ),
        ),
      ),
      // drawer คือปุ่ม 3 ขีด ซ้ายบนของ appbar โดย drawer เรียก drawerHome
      drawer: drawerHome(screenHeight, screenWidth),
    );
  }

  Drawer drawerHome(double screenHeight, double screenWidth) {
    double height = screenHeight;
    double width = screenWidth;
    return Drawer(
      // สร้าง Drawer
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.5,
            ),
          ),
          Container(
            // ปุ่ม เข้าสู่ระบบ
            width: width * 0.7,
            child: ElevatedButton(
              // ปุ่มสีน้ำเงิน
              style: ElevatedButton.styleFrom(primary: Colors.blue.shade900),
              child: Text(
                "เข้าสู่ระบบ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // เมื่อปุ่มถูกกดจะไปยังหน้า '/authen'
                Navigator.pushNamed(context, '/authen');
              },
            ),
          ),
          Container(
            // ปุ่ม สร้างบัญชีใหม่
            width: width * 0.7,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  // ปุ่มขาวกรอบดำ
                  side: BorderSide(color: Colors.black)),
              child: Text(
                "สร้างบัญชีใหม่",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue.shade900),
              ),
              onPressed: () {
                // เมื่อปุ่มถูกกดจะไปยังหน้า '/register'
                Navigator.pushNamed(context, '/register');
              },
            ),
          ),
        ],
      ),
    );
  }

  Card buildCard(String str) {
    // ฟังก์ชัน buildCard รับค่า str ที่เป็น String มา ซึ่งค่าที่ส่งมาจะเป็นชื่อบนปุ่ม
    return Card(
      // กำหนด Card สำหรับปุ่มยาวที่ใช้ใน body
      color: Colors.blue.shade900, // กำหนดสี
      margin: EdgeInsets.all(12.5), // กำหนดระยะขอบ
      child: ListTile(
        onTap: () {
          // เช็คค่า str แล้วให้ไปยังหน้านั้นๆเมื่อปุ่มถูกกด
          if (str == "ความรู้วิศวกรรมในงานก่อสร้าง") {
            // str เป็น ความรู้วิศวกรรมในงานก่อสร้าง ให้ไป '/general_topics' เมื่อถูกกด
            Navigator.pushNamed(context, '/general_topics');
          } else if (str == "เทคนิคการก่อสร้าง") {
            // str เป็น เทคนิคการก่อสร้าง ให้ไป '/technique_topics' เมื่อถูกกด
            Navigator.pushNamed(context, '/technique_topics');
          } else if (str == "พบช่างและถามตอบ") {
            // str เป็น พบช่างและถามตอบ ให้ไป '/contact' เมื่อถูกกด
            Navigator.pushNamed(context, '/contact');
          }
        },
        title: Center(
          child: Text(
            // กำหนดรายละเอียดของตัวหนังสือบนปุ่ม
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
    // การทำงานของ buildGridview เหมือนกับ buildCard มีการเช็คค่า str เพื่อเปลี่ยนหน้า
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
            // กำหนดรายละเอียดของตัวหนังสือบนปุ่ม
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
