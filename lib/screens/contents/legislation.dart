import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engineeronline/models/pdf_model.dart';
import 'package:engineeronline/screens/views/pdf.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Legislation extends StatefulWidget {
  Legislation({Key key, this.keys}) : super(key: key);
  final String keys;
  @override
  _LegislationState createState() => _LegislationState();
}

class _LegislationState extends State<Legislation> {
  final scrollDirection = Axis.vertical;
  List<dynamic> pdfModels = [];

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print("initialize legislation success");
      FirebaseFirestore.instance
          .collection("legislation")
          .orderBy('name')
          .snapshots()
          .listen((event) {
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          PdfModel model = PdfModel.fromMap(map);
          pdfModels.add(model);
        }
      });
    });
  }

  AutoScrollController controller;
  Future _scrollToOne() async {
    await controller.scrollToIndex(3, preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToTwo() async {
    await controller.scrollToIndex(11,
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
          if (text == "1.พระราชบัญญัติ") {
            _scrollToOne();
          } else if (text == "2.กฏกระทรวงที่เกี่ยวข้องกับการออกแบบ") {
            _scrollToTwo();
          } else {
            print("text error");
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
        onPressed: () {
          // get model and send to view pdf
          for (var i = 0; i < pdfModels.length; i++) {
            if (text == pdfModels[i].name) {
              print(pdfModels[i].name);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pdf(pdfModel: pdfModels[i]),
                  ));
            }
          }
        },
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
    readData();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
  }

  @override
  Widget build(BuildContext context) {
    List contents = [
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
      buildChapterButton("1.พระราชบัญญัติ"),
      buildChapterButton("2.กฏกระทรวงที่เกี่ยวข้องกับการออกแบบ"),
      Divider(
        height: 20,
        thickness: 1.5,
        color: Colors.black,
        indent: 20,
        endIndent: 20,
      ),
      buildChapter("1.พระราชบัญญัติ"),
      buildSubChapter(
          "พระราชบัญญัติควบคุมอาคาร พ.ศ. 2522 แก้ไขโดย (ฉบับที่ 2) พ.ศ. 2535, (ฉบับที่ 3) พ.ศ. 2543 (ฉบับที่ 4) พ.ศ. 2550 (ฉบับที่ 5) พ.ศ. 2558 และพระราชบัญญัติแก้ไขเพิ่มเติมบทบัญญัติแห่งกฎหมายที่เกี่ยวกับความรับผิดในทางอาญาของผู้แทนนิติบุคคล พ.ศ. 2560"),
      buildDetail("1.1 พระราชบัญญัติควบคุมอาคาร พ.ศ. 2522"),
      buildDetail("1.2 พระราชบัญญัติควบคุมอาคาร (ฉบับที่ 2) พ.ศ. 2535"),
      buildDetail("1.3 พระราชบัญญัติควบคุมอาคาร (ฉบับที่ 3) พ.ศ.2543"),
      buildDetail("1.4 พระราชบัญญัติควบคุมอาคาร (ฉบับที่ 4) พ.ศ. 2550"),
      buildDetail("1.5 พระราชบัญญัติควบคุมอาคาร (ฉบับที่ 5) พ.ศ. 2558"),
      buildChapter("2.กฏกระทรวงที่เกี่ยวข้องกับการออกแบบ"),
      buildDetail(
          "2.1 กฎกระทรวง ฉบับที่ 55 (พ.ศ. 2543) แก้ไขโดย กฎกระทรวง ฉบับที่ 58 (พ.ศ.2546) กฎกระทรวง ฉบับที่ 61 (พ.ศ. 2550) กฎกระทรวง ฉบับที่ 66 (พ.ศ. 2559) และ กฎกระทรวง ฉบับที่ 68 (พ.ศ. 2563) – ลักษณะอาคาร ส่วนต่างๆ ของอาคาร ที่ว่างภายนอก แนวอาคารและระยะต่างๆ ของอาคาร"),
      buildDetail("2.2 กฎกระทรวง ฉบับที่ 55 (พ.ศ. 2543)"),
      buildDetail(
          "2.3 กฎกระทรวง ฉบับที่ 58 (พ.ศ. 2546) แก้ไข กฎกระทรวง ฉบับที่ 55 (พ.ศ. 2543)"),
      buildDetail(
          "2.4 กฎกระทรวง ฉบับที่ 61 (พ.ศ. 2550) แก้ไข กฎกระทรวง ฉบับที่ 55 (พ.ศ. 2543)"),
      buildDetail(
          "2.5 กฎกระทรวง ฉบับที่ 66 (พ.ศ. 2559) แก้ไข กฎกระทรวง ฉบับที่ 55 (พ.ศ. 2543)"),
      buildDetail(
          "2.6 กฎกระทรวง ฉบับที่ 68 (พ.ศ. 25ุ63) แก้ไข กฎกระทรวง ฉบับที่ 55 (พ.ศ.2543)"),
      buildDetail(
          "2.7 กฎกระทรวง ฉบับที่ 39 (พ.ศ. 2537) แก้ไขโดย กฎกระทรวง ฉบับที่ 63 (พ.ศ. 2551) – ระบบป้องกันอัคคีภัย, ห้องน้ำและห้องส้วม, ระบบการจัดแสงสว่างและระบายอากาศ, ระบบจ่ายพลังงานไฟฟ้าสำรองกรณีฉุกเฉิน"),
      buildDetail(
          "2.8 กฎกระทรวง ฉบับที่ 63 (พ.ศ. 2551) แก้ไข กฎกระทรวง ฉบับที่ 39 (พ.ศ. 2537)"),
      buildDetail(
          "2.9 กฎกระทรวง ฉบับที่ 33 (พ.ศ. 2535) แก้ไขโดย กฎกระทรวง ฉบับที่ 42 (พ.ศ. 2537) ฉบับที่ 50 (พ.ศ. 2540) และ ฉบับที่ 64 (พ.ศ. 2564) – อาคารสูง อาคารขนาดใหญ่พิเศษ"),
      buildDetail("3.กฎกระทรวง ฉบับที่ 33 (พ.ศ. 2535)"),
      buildDetail(
          "4.กฎกระทรวง ฉบับที่ 42 (พ.ศ. 2537) แก้ไข กฎกระทรวง ฉบับที่ 33 (พ.ศ. 2535)"),
      buildDetail(
          "5.กฎกระทรวง ฉบับที่ 50 (พ.ศ. 2540) แก้ไข กฎกระทรวง ฉบับที่ 33 (พ.ศ. 2535)"),
      buildDetail(
          "6.กฎกระทรวง ฉบับที่ 69 (พ.ศ. 2564) แก้ไข กฎกระทรวง ฉบับที่ 33 (พ.ศ. 2535)"),
      buildDetail(
          "7.กฎกระทรวง ฉบับที่ 7 (พ.ศ. 2517) แก้ไขโดย กฎกระทรวง ฉบับที่ 41(พ.ศ. 2537) และ กฎกระทรวง ฉบับที่ 64 (พ.ศ. 2555)"),
      buildDetail("7.1 กฎกระทรวง ฉบับที่ 7 (พ.ศ. 2517)"),
      buildDetail(
          "7.2 กฎกระทรวง ฉบับที่ 64 (พ.ศ. 2555) แก้ไข กฎกระทรวง ฉบับที่ 7 (พ.ศ. 2517)"),
      buildDetail(
          "8.กฎกระทรวง ฉบับที่ 41 (พ.ศ. 2537) – ที่จอดรถ, อาคารจอดรถ, ระบบยกรถขึ้นลงฯด้วยลิฟต์, ระบบเคลื่อนย้ายรถด้วยเครื่องจักรกล"),
      buildDetail(
          "9.กฎกระทรวง กำหนดสิ่งอำนวยความสะดวกในอาคาร สำหรับผู้พิการหรือทุพพลภาพ และคนชรา พ.ศ. 2548 แก้ไขโดย กฎกระทรวงกำหนดสิ่งอำนวยความสะดวกในอาคารฯ (ฉบับที่ 2) พ.ศ. 2564"),
      buildDetail(
          "9.1 กฎกระทรวงกำหนดสิ่งอำนวยความสะดวกในอาคาร สำหรับผู้พิการหรือทุพพลภาพ และคนชรา พ.ศ. 2548"),
      buildDetail(
          "9.2 กฎกระทรวงกำหนดสิ่งอำนวยความสะดวกในอาคาร สำหรับผู้พิการหรือทุพพลภาพ และคนชรา (ฉบับที่ 2) พ.ศ. 2564 แก้ไข กฎกระทรวง กำหนดสิ่งอำนวยความสะดวกในอาคารฯ พ.ศ. 2548"),
      buildDetail(
          "10.กฎกระทรวงว่าด้วยการอนุญาตให้ใช้อาคารเพื่อประกอบกิจการโรงมหรสพ ประเภทและระบบความปลอดภัยของโรงมหรสพ และอัตราค่าธรรมเนียมสำหรับการอนุญาตให้ใช้อาคารเพื่อประกอบกิจการโรงมหรสพ พ.ศ. 2550"),
      buildDetail(
          "11.กฎกระทรวง กำหนดประเภทและระบบความปลอดภัยของอาคารที่ใช้เพื่อประกอบกิจการเป็นสถานบริการ พ.ศ. 2555"),
      buildDetail(
          "12.กฎกระทรวง ว่าด้วยการยกเว้น ผ่อนผัน หรือกำหนดเงื่อนไข ในการปฏิบัติตามกฎหมายว่าด้วยการควบคุมอาคารสำหรับอาคารในโครงการที่รัฐจัดให้มีหรือพัฒนาเพื่อเป็นที่อยู่สำหรับผู้มีรายได้น้อย พ.ศ. 2554"),
      buildDetail(
          "13.กฎกระทรวง ฉบับที่ 6 (พ.ศ. 2527) แก้ไขโดย กฎกระทรวง ฉบับที่ 48 (พ.ศ. 2540) และฉบับที่ 60 (พ.ศ. 2549) การออกแบบโครงสร้าง"),
      buildDetail("13.1 กฎกระทรวง ฉบับที่ 6 (พ.ศ. 2527)"),
      buildDetail(
          "13.2 กฎกระทรวง ฉบับที่ 48 (พ.ศ. 2540) แก้ไข กฎกระทรวง ฉบับที่ 6 (พ.ศ. 2527)"),
      buildDetail(
          "13.3 กฎกระทรวง ฉบับที่ 60 (พ.ศ. 2549) แก้ไข กฎกระทรวง ฉบับที่ 6 (พ.ศ. 2527)"),
      buildDetail(
          "14.กฎกระทรวงกำหนดการรับน้ำหนัก ความต้านทาน ความคงทนของอาคารและพื้นดินที่รองรับอาคารในการต้านทานแรงสั่นสะเทือนของแผ่นดินไหว พ.ศ. 2564"),
      buildDetail(
          "15.กฎกระทรวง ฉบับที่ 44 (พ.ศ. 2538) แก้ไขโดย กฎกระทรวง ฉบับที่ 51 (พ.ศ. 2541) – ระบบการระบายน้ำ, การกำจัดขยะฯ"),
      buildDetail("15.1 กฎกระทรวง ฉบับที่ 44 (พ.ศ. 2538)"),
      buildDetail(
          "15.2 กฎกระทรวง ฉบับที่ 51 (พ.ศ. 2541) แก้ไข กฎกระทรวง ฉบับที่ 44 (พ.ศ. 2538)"),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "กฏหมายเทศบัญญัติ",
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
