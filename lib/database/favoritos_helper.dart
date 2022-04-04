import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/models/favoritos_model.dart';
import 'package:practica2/routes/routes.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';



class DatabaseFav {
  static final _nombreBD = "PATM2022";
  static final _versionBD = 1;

  static  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, _nombreBD);
    return await openDatabase(rutaBD,
        version: _versionBD, onCreate: _crearTablas
        //,onUpgrade: _updTablas
        );
  }

  

  _crearTablas(Database db, int version) {
    db.execute("CREATE TABLE favoritos (id_fav INTEGER primary key ,title varchar(25), backdropPath varchar(100))");
  }
   _updTablas(Database db, int oldVersion, int newVersion) {

  }

  Future<int> insertar(Map<String, dynamic> row) async {
    var dbConexion =await database ;
    return dbConexion.insert("favoritos", row);
  }

  Future<int> update(Map<String, dynamic> row) async{
    var dbConexion =await database ;
    return dbConexion.update("favoritos", row, where:"id_fav=?",whereArgs: [row['id_fav']]);
  }

  Future<int> delete(int id_fav) async{
    var dbConexion =await database ;
    return await dbConexion.delete("favoritos",where:"id_fav=?",whereArgs: [id_fav] );
  }

  Future<List<FavDAO>> getAllFavorites() async{
    var dbConexion=await database;
    var result= await dbConexion.query("favoritos");
    var list = result.map((fav)=>FavDAO.fromMap(fav)).toList();
    return list;
  }
}
