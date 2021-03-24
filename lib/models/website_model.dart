class WebsiteModel {
  // Field
  String name, url;
  // Method
  WebsiteModel(this.name, this.url);

  WebsiteModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    url = map['url'];
  }
}
