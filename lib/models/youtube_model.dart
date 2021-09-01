class YoutubeModel {
  // Field
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
