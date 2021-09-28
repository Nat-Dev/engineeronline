class YoutubeModel {
  // Field
  // model ของ youtube ประกอบไปด้วย
  // url ภาพปก, ชือหัวข้อ, url ของเว็บ, ชื่อผู้ใช้ของผู้โพสต์, อีเมลล์ของผู้โพสต์, หมวดหมู่ของหัวข้อ
  String thumbnail, name, url, username, email, type;
  // Method
  YoutubeModel(this.thumbnail, this.name, this.url, this.username, this.email,
      this.type);

  YoutubeModel.fromMap(Map<String, dynamic> map) {
    thumbnail = map['thumbnail'];
    name = map['name'];
    url = map['url'];
    username = map['username'];
    email = map['email'];
    type = map['type'];
  }
}
