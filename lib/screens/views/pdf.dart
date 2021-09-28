import 'package:engineeronline/models/pdf_model.dart';
import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class Pdf extends StatefulWidget {
  final PdfModel pdfModel;
  Pdf({Key key, this.pdfModel}) : super(key: key);
  // กำหนดตัวแปร และรับค่า pdf model มาใส่ในตัวแปร
  @override
  _PdfState createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  PdfModel model;

  @override
  void initState() {
    // เอาค่าที่รับมาใส่ลงในตัวแปร model อีกที
    super.initState();
    model = widget.pdfModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // appbar เป็นชื่อหัวข้อ
        backgroundColor: Colors.blue.shade900,
        title: Text(
          // ดูชื่อหัวข้อใน field name ของ model ว่ามีค่าเป็นอะไร ให้แสดงค่านั้น
          // ถ้า model ไม่มีชื่อ ให้แสดงชื่อหัวข้อเป็น "Open Pdf" กรณีนี้จะไม่เกิดขึ้น
          model.name == null ? "Open Pdf" : model.name,
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
      body: model.url == null
          // body แสดง pdf จาก url ถ้า url เป็น null ให้แสดงตัวหมุน loading
          ? Center(child: CircularProgressIndicator())
          : PDF.network(model.url,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width),
    );
  }
}
