class TrailerModel {
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  TrailerModel({
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  factory TrailerModel.fromMap(Map<String, dynamic> map) {
    return TrailerModel(
        name: map['name'],
        key: map['key'],
        site: map['site'],
        size: map['size'],
        type: map['type'],
        official: map['official'],
        publishedAt: map['publishedAt'],
        id: map['id']);
  }
}