class WebsiteModel {
  // Field
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
