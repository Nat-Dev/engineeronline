class WebsiteModel {
  // Field
  String name, url, username, email;
  // Method
  WebsiteModel(this.name, this.url, this.username, this.email);

  WebsiteModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    url = map['url'];
    username = map['username'];
    email = map['email'];
  }
}
