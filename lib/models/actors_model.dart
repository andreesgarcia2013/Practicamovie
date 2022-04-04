class ActorsModel {
  int? id;
  String? name;
  String? profilePath;

  ActorsModel({
    this.id,
    this.name,
    this.profilePath,
  });

  factory ActorsModel.fromMap(Map<String, dynamic> map) {
    return ActorsModel(
        id: map['id'],
        name: map['name'],
        profilePath: map['profile_path']
        );
  }
}
