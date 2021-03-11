class WebViewModel {
  // Field
  String thumbnail, name, url;
  // Method
  WebViewModel(this.thumbnail, this.name, this.url);

  WebViewModel.fromMap(Map<String, dynamic> map) {
    thumbnail = map['thumbnail'];
    name = map['name'];
    url = map['url'];
  }
}
