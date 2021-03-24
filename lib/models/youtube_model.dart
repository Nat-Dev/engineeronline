class YoutubeModel {
  // Field
  String thumbnail, name, url;
  // Method
  YoutubeModel(this.thumbnail, this.name, this.url);

  YoutubeModel.fromMap(Map<String, dynamic> map) {
    thumbnail = map['thumbnail'];
    name = map['name'];
    url = map['url'];
  }
}
