

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/database/database_helper.dart';
import 'package:practica2/database/favoritos_helper.dart';
import 'package:practica2/models/favoritos_model.dart';
import 'package:sqflite/sqflite.dart';

class DetailMovieScreen extends StatefulWidget {
  FavDAO? objFav;
  DetailMovieScreen({Key? key, this.objFav}) : super(key: key);
  
  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  bool _isFavorited=false;
  late DatabaseNotes dbNotes;
  late bool ress;
  @override
  void initState() {
    super.initState();
    dbNotes = DatabaseNotes();
  }
  
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String title=movie['title'];
    String backdropPath=movie['backdrop_path'];
    final Future<bool> _value=dbNotes.metodo(movie['title']);
    return Scaffold(
      appBar: AppBar(
        title:Text(movie['title']) ,
        actions: <Widget>[
           IconButton(onPressed:
             _toggleFavorite
          // //   FavDAO objFav=FavDAO(title: movie['title']);
          // //   dbNotes.insertarFavorito(objFav.toMap()).then((value){
          // //   if (value>0) {
          // //      ScaffoldMessenger.of(context).showSnackBar(
          // //     SnackBar(content: Text('Agregada'))
          // //   );
          // //   }else{
          // //   ScaffoldMessenger.of(context).showSnackBar(
          // //     SnackBar(content: Text('Error in your request'))
          // //   );
          // // }
          // //   }); 
           , 
           icon: ( _isFavorited
                 ? const Icon(Icons.favorite_border_outlined)
                 : const Icon(Icons.favorite_rounded)),
             color: Colors.red[500],
           )
        ]
      ),
      body: Text(movie['title']),
    );
  }
  void _toggleFavorite() {
  setState(() {
    if (_isFavorited==true) {
      _isFavorited = false;
    } else {
      _isFavorited = true;
    }
  });
}
}