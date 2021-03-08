class GeneralModel {
  // Field
  String thumbnail, name, url;
  // Method
  GeneralModel(this.thumbnail, this.name, this.url);

  GeneralModel.fromMap(Map<String, dynamic> map) {
    thumbnail = map['thumbnail'];
    name = map['name'];
    url = map['url'];
  }
}
