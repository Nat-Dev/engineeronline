import 'package:flutter/material.dart';

class Structure extends StatefulWidget {
  @override
  _StructureState createState() => _StructureState();
}

Align buildChapter(String text) {
  return Align(
    alignment: Alignment(0, 0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: Colors.green.shade900,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Align buildSubChapter(String text) {
  return Align(
    alignment: Alignment(-1, 0),
    child: TextButton(
      onPressed: null,
      child: Text(
        text,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 18,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Align buildDetail(String text) {
  return Align(
    alignment: Alignment(-1, 0),
    child: TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

SizedBox buildSizedBox(double h) {
  return SizedBox(
    height: h,
  );
}

class _StructureState extends State<Structure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "งานโยธาและโครงสร้าง",
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
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: ListView(
            children: [
              buildSizedBox(20),
              buildChapter("งานเตรียมสถานที่ก่อสร้าง"),
              buildDetail("1.ขอบเขตของงาน"),
              buildDetail("2.การสำรวจวางแนวและหมุดระดับอ้างอิง"),
              buildDetail("3.การตัดต้นไม้ในบริเวณก่อสร้าง"),
              buildDetail("4.การพบโบราณวัตถุหรือของมีค่า"),
              buildDetail("5.การโยกย้ายระบบสาธาณูปโภค"),
              buildDetail("6.การป้องกันความเสียหาย"),
              buildDetail("7.การรื้อถอนอาคารและสิ่งก่อสร้างเดิม"),
              buildSizedBox(20),
              buildChapter("งานดินและรากฐาน"),
              buildSubChapter("งานดิน"),
              buildDetail("1.ขอบเขตของงาน"),
              buildDetail("2.บททั่วไป"),
              buildDetail("3.มาตรฐานกำหนดในการทำงาน"),
              buildSubChapter("งานเสาเข็มเจาะ"),
              buildDetail("1.ขอบเขตของงาน"),
              buildDetail("2.บททั่วไป"),
              buildDetail("3.ข้อกำหนดสำหรับเสาเข็ม"),
              buildDetail("4.ASBUILT DRAWINGS"),
              buildDetail("5.ความปลอดภัย"),
              buildSubChapter("งานเสาเข็มตอก"),
              buildDetail("1.ขอบเขตของงาน"),
              buildDetail("2.บททั่วไป"),
              buildDetail("3.ข้อกำหนดสำหรับเสาเข็ม"),
              buildDetail("4.ความคลาดเคลื่อนที่ยอมให้"),
              buildDetail(
                  "5.การแก้ไขฐานรากในกรณีที่มีความคลาดเคลื่อนของการตอกเสาเข็ม"),
              buildDetail("6.การรายงานผล"),
              buildDetail("7.การสรุปผลรายงาน"),
              buildSubChapter("งานเตรียมฐานราก"),
              buildDetail("1.ขอบเขตของงาน"),
              buildDetail("2.บททั่วไป"),
              buildDetail("3.การสกัดต่อหัวเสาเข็ม"),
              buildDetail("4.การเตรียมงานฐานราก"),
              buildSizedBox(20),
              buildChapter("การก่อสร้างงานคอนกรีตเสริมเหล็ก"),
              buildSubChapter("งานคอนกรีต"),
              buildDetail("1.ขอบเขตของงาน"),
              buildDetail("2.บททั่วไป"),
              buildDetail(
                  "3.มาตรฐานงานคอนกรีต และคอนกรีตเสริมเหล็ก ตาม มยผ 1101-52"),
              buildDetail("4.มาตรฐานงานคอนกรีตอัดแรง ตามมาตรฐาน มยผ. 1102-52"),
              buildDetail("5.งานโครงสร้างคอนกรีตเสริมเหล็ก"),
              buildSubChapter("งานแบบหล่อและค้ำยัน"),
              buildDetail("1.ขอบเขตของงาน"),
              buildDetail("2.บททั่วไป"),
              buildDetail("3.การคำนวณออกแบบ"),
              buildDetail("4.รูปแบบ"),
              buildDetail("5.กำหนดระยะเวลาถอดไม้"),
              buildSubChapter("งานเหล็กเสริมคอนกรีต"),
              buildDetail("1.ขอบเขตของงาน"),
              buildDetail("2.บททั่วไป"),
              buildDetail("3.ข้อกำหนดของวัสดุสำหรับเหล็กเสริมคอนกรีต"),
              buildDetail("4.การตัดและประกอบสำหรับเหล็กเสริมคอนกรีต"),
              buildDetail("5.การต่อเหล็ก"),
              buildDetail("6.การควบคุมคุณภาพ"),
              buildSubChapter("งานเหล็กรูปพรรณ"),
              buildDetail("1.ขอบเขตของงาน"),
              buildDetail("2.บททั่วไป"),
              buildDetail("3.วัสดุ"),
              buildDetail("4.การตัดและต่อเหล็กรูปพรรณ"),
              buildDetail("5.การประกอบและติดตั้งเหล็กรูปพรรณ"),
              buildDetail("6.ฐานรองรับหรือจุดยึดโครงเหล็กรูปพรรณ"),
              buildDetail("7.การตรวจสอบคุณภาพ"),
              buildDetail("8.การป้องกันสนิมและทาสีป้องกันสนิม"),
              buildSubChapter("การป้องกันความชื้น"),
              buildDetail("1.ขอบเขตของงาน"),
              buildSubChapter("งานหลังคา"),
              buildDetail("1.ขอบเขตของงาน"),
              buildDetail("2.วัสดุ"),
              buildDetail("3.การติดตั้ง"),
              buildDetail("4.การป้องกันการซึม"),
              buildSubChapter(
                  "การทำแผ่นป้ายค่าการออกแบบการรับน้ำหนักของพื้นที่"),
              buildDetail("1.ขอบเขตของงาน"),
            ],
          ),
        ),
      ),
    );
  }
}
