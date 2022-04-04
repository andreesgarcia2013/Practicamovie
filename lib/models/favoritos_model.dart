class FavDAO {
  int? id_fav;
  String? title;

  FavDAO({this.id_fav,this.title});
  factory FavDAO.fromMap(Map<String, dynamic>favMap){
    return FavDAO(
      id_fav:favMap['id_fav'],
      title: favMap['title']);
  }

  Map<String, dynamic> toMap(){
    return{
      "id_fav": id_fav,
      "title": title,
    };
  }
}