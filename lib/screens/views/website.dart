import 'package:engineeronline/models/website_model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Website extends StatefulWidget {
  final WebsiteModel websiteModel;
  Website({Key key, this.websiteModel}) : super(key: key);
  // กำหนดตัวแปร และรับค่า website model มาใส่ในตัวแปร
  @override
  _WebsiteState createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {
  WebsiteModel model;

  @override
  void initState() {
    // เอาค่าที่รับมาใส่ลงในตัวแปร model อีกที
    super.initState();
    model = widget.websiteModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // appbar เป็นชื่อหัวข้อ
        backgroundColor: Colors.blue.shade900,
        title: Text(
          // ดูชื่อหัวข้อใน field name ของ model ว่ามีค่าเป็นอะไร ให้แสดงค่านั้น
          // ถ้า model ไม่มีชื่อ ให้แสดงชื่อหัวข้อเป็น "Open Website" กรณีนี้จะไม่เกิดขึ้น
          model.name == null ? "Open Website" : model.name,
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
          // body แสดง website จาก url ถ้า url เป็น null ให้แสดงตัวหมุน loading
          ? Center(child: CircularProgressIndicator())
          : WebView(
              initialUrl: model.url, // เปิดเว็บไซต์จาก url
              // เปิดใช้งาน javascriptMode เพื่อให้ใช้งานหน้าเว็บไซต์ได้
              javascriptMode: JavascriptMode.unrestricted,
              // ถ้าเป็น url ที่มีวีดีโอ วีดีโอจะยังไม่ถูกเล่นทันที ต้องให้ผู้ใช้กดเล่นเอง
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy
                  .require_user_action_for_all_media_types,
            ),
    );
  }
}
