class YoutubeModel {
  // Field
  String thumbnail, name, url, username, email;
  // Method
  YoutubeModel(this.thumbnail, this.name, this.url, this.username, this.email);

  YoutubeModel.fromMap(Map<String, dynamic> map) {
    thumbnail = map['thumbnail'];
    name = map['name'];
    url = map['url'];
    username = map['username'];
    email = map['email'];
  }
}
