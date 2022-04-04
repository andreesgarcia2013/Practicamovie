class NotesDAO {
  int? id_nota;
  String? titulo;
  String? descripcion;

  NotesDAO({this.id_nota,this.titulo,this.descripcion});
  factory NotesDAO.fromMap(Map<String, dynamic>noteMap){
    return NotesDAO(
      id_nota:noteMap['id_nota'],
      titulo:noteMap['titulo'],
      descripcion:noteMap['descripcion']);
  }

  Map<String, dynamic> toMap(){
    return{
      "id_nota": id_nota,
      "titulo": titulo,
      "descripcion": descripcion

    };
  }
}