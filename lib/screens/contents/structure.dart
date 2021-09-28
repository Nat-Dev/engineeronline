import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Structure extends StatefulWidget {
  Structure({Key key, this.keys}) : super(key: key);
  final String keys;
  @override
  _StructureState createState() => _StructureState();
}

class _StructureState extends State<Structure> {
  // การทำงานเหมือนกับ architecture.dart
  final scrollDirection = Axis.vertical;

  AutoScrollController controller;
  Future _scrollToOne() async {
    await controller.scrollToIndex(11,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToTwo() async {
    await controller.scrollToIndex(19,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToThree() async {
    await controller.scrollToIndex(43,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToFour() async {
    await controller.scrollToIndex(49,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToFive() async {
    await controller.scrollToIndex(55,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToSix() async {
    await controller.scrollToIndex(62,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToSeven() async {
    await controller.scrollToIndex(71,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToEight() async {
    await controller.scrollToIndex(73,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToNine() async {
    await controller.scrollToIndex(78,
        preferPosition: AutoScrollPosition.begin);
  }

  Align buildChapter(String text) {
    return Align(
      alignment: Alignment(0, 0),
      child: TextButton(
        onPressed: null,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.green.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Align buildChapterButton(String text) {
    return Align(
      alignment: Alignment(-1, 0),
      child: TextButton(
        onPressed: () {
          if (text == "งานเตรียมสถานที่ก่อสร้าง") {
            _scrollToOne();
          } else if (text == "งานดินและรากฐาน") {
            _scrollToTwo();
          } else if (text == "งานคอนกรีต") {
            _scrollToThree();
          } else if (text == "งานแบบหล่อและค้ำยัน") {
            _scrollToFour();
          } else if (text == "งานเหล็กเสริมคอนกรีต") {
            _scrollToFive();
          } else if (text == "งานเหล็กรูปพรรณ") {
            _scrollToSix();
          } else if (text == "การป้องกันความชื้น") {
            _scrollToSeven();
          } else if (text == "งานหลังคา") {
            _scrollToEight();
          } else if (text ==
              "การทำแผ่นป้ายค่าการออกแบบการรับน้ำหนักของพื้นที่") {
            _scrollToNine();
          }
        },
        child: Text(
          text,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18,
            color: Colors.green.shade900,
            fontWeight: FontWeight.bold,
          ),
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

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = [
      Align(
        alignment: Alignment(0, 0),
        child: TextButton(
          onPressed: null,
          child: Text(
            "ไปที่บท",
            style: TextStyle(
              fontSize: 18,
              color: Colors.purple.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      buildChapterButton("งานเตรียมสถานที่ก่อสร้าง"),
      buildChapterButton("งานดินและรากฐาน"),
      buildChapterButton("งานคอนกรีต"),
      buildChapterButton("งานแบบหล่อและค้ำยัน"),
      buildChapterButton("งานเหล็กเสริมคอนกรีต"),
      buildChapterButton("งานเหล็กรูปพรรณ"),
      buildChapterButton("การป้องกันความชื้น"),
      buildChapterButton("งานหลังคา"),
      buildChapterButton("การทำแผ่นป้ายค่าการออกแบบการรับน้ำหนักของพื้นที่"),
      Divider(
        height: 20,
        thickness: 1.5,
        color: Colors.black,
        indent: 20,
        endIndent: 20,
      ),
      buildChapter("งานเตรียมสถานที่ก่อสร้าง"),
      buildDetail("1.ขอบเขตของงาน"),
      buildDetail("2.การสำรวจวางแนวและหมุดระดับอ้างอิง"),
      buildDetail("3.การตัดต้นไม้ในบริเวณก่อสร้าง"),
      buildDetail("4.การพบโบราณวัตถุหรือของมีค่า"),
      buildDetail("5.การโยกย้ายระบบสาธาณูปโภค"),
      buildDetail("6.การป้องกันความเสียหาย"),
      buildDetail("7.การรื้อถอนอาคารและสิ่งก่อสร้างเดิม"),
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
      buildDetail("5.การแก้ไขฐานรากในกรณีที่มีความคลาดเคลื่อนของการตอกเสาเข็ม"),
      buildDetail("6.การรายงานผล"),
      buildDetail("7.การสรุปผลรายงาน"),
      buildSubChapter("งานเตรียมฐานราก"),
      buildDetail("1.ขอบเขตของงาน"),
      buildDetail("2.บททั่วไป"),
      buildDetail("3.การสกัดต่อหัวเสาเข็ม"),
      buildDetail("4.การเตรียมงานฐานราก"),
      buildChapter("งานคอนกรีต"),
      buildDetail("1.ขอบเขตของงาน"),
      buildDetail("2.บททั่วไป"),
      buildDetail("3.มาตรฐานงานคอนกรีต และคอนกรีตเสริมเหล็ก ตาม มยผ 1101-52"),
      buildDetail("4.มาตรฐานงานคอนกรีตอัดแรง ตามมาตรฐาน มยผ. 1102-52"),
      buildDetail("5.งานโครงสร้างคอนกรีตเสริมเหล็ก"),
      buildChapter("งานแบบหล่อและค้ำยัน"),
      buildDetail("1.ขอบเขตของงาน"),
      buildDetail("2.บททั่วไป"),
      buildDetail("3.การคำนวณออกแบบ"),
      buildDetail("4.รูปแบบ"),
      buildDetail("5.กำหนดระยะเวลาถอดไม้"),
      buildChapter("งานเหล็กเสริมคอนกรีต"),
      buildDetail("1.ขอบเขตของงาน"),
      buildDetail("2.บททั่วไป"),
      buildDetail("3.ข้อกำหนดของวัสดุสำหรับเหล็กเสริมคอนกรีต"),
      buildDetail("4.การตัดและประกอบสำหรับเหล็กเสริมคอนกรีต"),
      buildDetail("5.การต่อเหล็ก"),
      buildDetail("6.การควบคุมคุณภาพ"),
      buildChapter("งานเหล็กรูปพรรณ"),
      buildDetail("1.ขอบเขตของงาน"),
      buildDetail("2.บททั่วไป"),
      buildDetail("3.วัสดุ"),
      buildDetail("4.การตัดและต่อเหล็กรูปพรรณ"),
      buildDetail("5.การประกอบและติดตั้งเหล็กรูปพรรณ"),
      buildDetail("6.ฐานรองรับหรือจุดยึดโครงเหล็กรูปพรรณ"),
      buildDetail("7.การตรวจสอบคุณภาพ"),
      buildDetail("8.การป้องกันสนิมและทาสีป้องกันสนิม"),
      buildChapter("การป้องกันความชื้น"),
      buildDetail("1.ขอบเขตของงาน"),
      buildChapter("งานหลังคา"),
      buildDetail("1.ขอบเขตของงาน"),
      buildDetail("2.วัสดุ"),
      buildDetail("3.การติดตั้ง"),
      buildDetail("4.การป้องกันการซึม"),
      buildChapter("การทำแผ่นป้ายค่าการออกแบบการรับน้ำหนักของพื้นที่"),
      buildDetail("1.ขอบเขตของงาน"),
    ];
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
            scrollDirection: scrollDirection,
            controller: controller,
            children: <Widget>[
              ...List.generate(contents.length, (index) {
                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: controller,
                  index: index,
                  child: contents[index],
                  highlightColor: Colors.black.withOpacity(0.1),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
