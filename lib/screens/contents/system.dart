import 'package:flutter/material.dart';

class System extends StatefulWidget {
  @override
  _SystemState createState() => _SystemState();
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

class _SystemState extends State<System> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "งานวิศวกรรมระบบ",
          style: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
            fontSize: 19,
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
              buildChapter("งานวิศวกรรมระบบไฟฟ้า สื่อสาร ป้องกันอัคคีภัย"),
              buildDetail("1.ข้อกำหนดเฉพาะ"),
              buildDetail("2.เงื่อนไขทั่วไป"),
              buildDetail("3.ระบบและวิธีติดตั้ง"),
              buildDetail("4.มาตรฐานวัสดุและอุปกรณ์ทั่วไป"),
              buildDetail("5.แผงสวิตช์จ่ายไฟฟ้ารวม"),
              buildDetail("6.Data Concentrator"),
              buildDetail(
                  "7.ระบบไฟฟ้าแสงสว่างฉุกเฉินและโคมไฟป้ายทางออกฉุกเฉิน"),
              buildDetail("8.ระบบเสียงประกาศ"),
              buildDetail("9.ระบบเสาอากาศโทรทัศน์รวม"),
              buildDetail("10.ระบบโทรศัพท์ (TELEPHONE SYSTEM)"),
              buildDetail(
                  "11.ระบบสัญญาณเรียกพยาบาลแบบไอพี (IP NURSE CALL SYSTEM)"),
              buildDetail("12.ระบบสื่อสารภายในแบบไอพี (IP INTERCOM SYSTEM)"),
              buildDetail("13.ระบบควบคุมไฟฟ้าแสงสว่าง (Lighting Control)"),
              buildDetail("14.อุปกรณ์ป้องกันแรงดันเสิร์จ"),
              buildDetail("15.ระบบคอมพิวเตอร์ (COMPUTER SYSTEM)"),
              buildDetail(
                  "16.ระบบโทรทัศน์วงจรปิด (CLOSED CIRCUIT TELEVISION SYSTEM)"),
              buildDetail(
                  "17.ระบบควบคุมอาคารอัตโนมัติ (Building Management System, BMS)"),
              buildDetail("18.ระบบไฟฟ้าแบบแยกส่วน (Isolation Panel Board)"),
              buildDetail(
                  "19.ระบบสัญญาณแจ้งเหตุเพลิงไหม้อัตโนมัติ (FIRE ALARM SYSTEM)"),
              buildDetail("20.ระบบป้องกันฟ้าผ่า (LIGHTNING PROTECTION SYSTEM)"),
              buildDetail("21.รายชื่อผลิตภัณฑ์มาตรฐาน"),
              buildSizedBox(20),
              buildChapter("งานวิศวกรรมระบบปรับอากาศและระบายอากาศ"),
              buildDetail("1.ข้อกำหนดทั่วไป"),
              buildDetail("2.ขอบเขตของงาน"),
              buildDetail("3.งานที่เกี่ยวข้องกับผู้รับจ้างก่อสร้าง"),
              buildDetail("4.เครื่องปรับอากาศแบบแยกส่วน"),
              buildDetail("5.เครื่องสูบน้ำ"),
              buildDetail("6.เครื่องส่งลมเย็น"),
              buildDetail("7.พัดลมระบายอากาศ"),
              buildDetail("8.ระบบส่งลมและอุปกรณ์"),
              buildDetail("9.ฉนวนหุ้มท่อลม"),
              buildDetail("10.ท่อน้ำและการติดตั้ง"),
              buildDetail("11.วาล์วและอุปกรณ์ประกอบท่อน้ำ"),
              buildDetail("12.ฉนวนหุ้มท่อน้ำ"),
              buildDetail("13.ระบบไฟฟ้า"),
              buildDetail("14.อุปกรณ์ควบคุมอัตโนมัติ"),
              buildDetail("15.การทำความสะอาดและการตบแต่ง"),
              buildDetail("16.การปรับแต่งระบบฯและการทดสอบการใช้งาน"),
              buildDetail("17.การป้องกันไฟ และควันลาม"),
              buildDetail("18.การสั่นสะเทือน และเสียง"),
              buildDetail("19.การทาสีป้องกันการผุกร่อนและรหัสสี"),
              buildDetail("20.ระบบจัดการอุปกรณ์เครื่องทำน้ำเย็น(CPM)"),
              buildDetail(
                  "21.ระบบขจัดละอองน้ำมันและกลิ่นสำหรับปล่องควันในครัว"),
              buildDetail("22.ระบบฆ่าเชื้อด้วยรังสีอัลตราไวโลเลตใน HVAC"),
              buildDetail("23.ระบบระบายอากาศแบบดึงความเย็นกลับมาใช้ใหม่"),
              buildDetail("24.รายการวัสดุ"),
              buildSizedBox(20),
              buildChapter("งานวิศวกรรมระบบสุขาภิบาลและดับเพลิง"),
              buildDetail("1.ขอบเขตของงาน"),
              buildDetail("2.โค๊ต มาตรฐาน และกฏเกณฑ์ ในการออกแบบ"),
              buildDetail("3.ความรับผิดชอบของผู้รับจ้าง"),
              buildDetail(
                  "4.คุณสมบัติของผู้รับจ้าง และคำแนะนำสำหรับเจ้าหน้าที่ และคนงาน"),
              buildDetail("5.ตัวอย่าง"),
              buildDetail("6.ระบบควบคุมส่วนกลาง และป้ายชื่อต่างๆ"),
              buildDetail("7.ปลอกรองท่อ การตัด การปะ การป้องกันรั่วซึม"),
              buildDetail("8.ข้อต่อ และการต่อท่อ"),
              buildDetail("9.การแขวนโยงท่อและยึดท่อ"),
              buildDetail("10.ช่องทำความสะอาด ตะแกรงระบายน้ำ และแทรป"),
              buildDetail("11.เครื่องสุขภัณฑ์"),
              buildDetail("12.ระบบน้ำประปา"),
              buildDetail("13.ระบบน้ำร้อน"),
              buildDetail("14.ระบบระบายน้ำ"),
              buildDetail("15.ระบบระบายน้ำเสีย"),
              buildDetail("16.ระบบป้องกันอัคคีภัย"),
              buildDetail(
                  "17.การขุดกลบร่องที่วางท่อ (EXCAVATION & BACKFILLING)"),
              buildDetail("18.วาล์วและวัสดุอุปกรณ์"),
              buildDetail("19.การทาสีป้องกัน (PROTECTIVE PAINTING)"),
              buildDetail(
                  "20.ฐานรองรับ และการขจัดความสั่นสะเทือนของเครื่องจักรกลทุกชนิด}"),
              buildDetail("21.ระบบไฟฟ้า"),
              buildDetail("22.การทดสอบ"),
              buildDetail("23.การฆ่าเชื้อโรคและทำความสะอาด"),
              buildDetail("24.การรับประกัน"),
              buildDetail(
                  "25.ผลิตภัณฑ์ตัวอย่าง SANITARY & FIRE PROTECTION SYSTEM"),
            ],
          ),
        ),
      ),
    );
  }
}
