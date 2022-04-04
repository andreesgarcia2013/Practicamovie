import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/models/favoritos_model.dart';
import 'package:practica2/models/notes_Model.dart';
import 'package:practica2/routes/routes.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class DatabaseNotes {
  static final _nombreBD = "PATM2022";
  static final _versionBD = 1;
  
  static  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    //Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(await getDatabasesPath(), "databd.db");
    return await openDatabase(rutaBD,
        version: _versionBD, onCreate: _crearTablas
        //,onUpgrade: _updTablas
        );
  }

  

  _crearTablas(Database db, int version) async {
    await db.execute("Create table if not exists tbl_notas (id_nota INTEGER primary key ,titulo varchar(25), descripcion varchar(100))");
    await db.execute("Create table if not exists favoritos (id_fav INTEGER primary key ,title varchar(100))");
  }

  _updTablas(Database db, int oldVersion, int newVersion) {

  }
  Future<int> insertar(Map<String, dynamic> row) async {
    var dbConexion =await database ;
    return dbConexion.insert("tbl_notas", row);
  }

  Future<int> insertarFavorito(Map<String, dynamic> row) async {
    var dbConexion =await database ;
    return dbConexion.insert("favoritos", row);
  }

  Future<int> insertarFav(Map<String, dynamic> row) async {
    var dbConexion =await database ;
    return dbConexion.insert("favoritos", row);
  }

  Future<int> update(Map<String, dynamic> row) async{
    var dbConexion =await database ;
    return dbConexion.update("tbl_notas", row, where:"id_nota=?",whereArgs: [row['id_nota']]);
  }

  Future<int> delete(int id_nota) async{
    var dbConexion =await database ;
    return await dbConexion.delete("tbl_notas",where:"id_nota=?",whereArgs: [id_nota] );
  }

  Future<int> deleteFav(int id_fav) async{
    var dbConexion =await database ;
    return await dbConexion.delete("favoritos",where:"id_fav=?",whereArgs: [id_fav] );
  }

  Future<List<NotesDAO>> getAllNotes() async{
    var dbConexion=await database;
    var result= await dbConexion.query("tbl_notas");
    var list = result.map((note)=>NotesDAO.fromMap(note)).toList();
    return list;
  }

  Future<List<FavDAO>> getAllFav() async{
    var dbConexion=await database;
    var result= await dbConexion.query("favoritos");
    var list = result.map((fav)=>FavDAO.fromMap(fav)).toList();
    return list;
  }

  Future<int> getProductById(String title) async {
   final db = await database; 
   var result = await db.rawQuery('SELECT * FROM favoritos WHERE title=?', [title]); 
    if (result.isNotEmpty) {
      return 1;
    } else {
      return 0;
    }
    
   //return true;
}
Future<bool> metodo(String title) async{
  final db = await database; 
  var result = await db.rawQuery('SELECT * FROM favoritos WHERE title=?', [title]); 
  if (result.isEmpty) {
      return true;
    }
    else{
      return false;
    }
}


}
