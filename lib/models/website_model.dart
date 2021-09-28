class WebsiteModel {
  // Field
  // model ของ website ประกอบไปด้วย
  // ชือหัวข้อ, url ของเว็บ, ชื่อผู้ใช้ของผู้โพสต์, อีเมลล์ของผู้โพสต์, หมวดหมู่ของหัวข้อ
  String name, url, username, email, type;
  // Method
  WebsiteModel(this.name, this.url, this.username, this.email, this.type);

  WebsiteModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    url = map['url'];
    username = map['username'];
    email = map['email'];
    type = map['type'];
  }
}
