class PdfModel {
  // Field
  // model ของ PDF ประกอบไปด้วย
  // ชือหัวข้อ, url ของ pdf, ชื่อผู้ใช้ของผู้โพสต์, อีเมลล์ของผู้โพสต์, หมวดหมู่ของหัวข้อ
  String name, url, username, email, type;
  // Method
  PdfModel(this.name, this.url, this.username, this.email, this.type);

  PdfModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    url = map['url'];
    username = map['username'];
    email = map['email'];
    type = map['type'];
  }
}
