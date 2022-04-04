

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/database/database_helper.dart';
import 'package:practica2/database/favoritos_helper.dart';
import 'package:practica2/models/actors_model.dart';
import 'package:practica2/models/favoritos_model.dart';
import 'package:practica2/models/trailer_model.dart';
import 'package:practica2/network/api_actors.dart';
import 'package:practica2/network/api_trailer.dart';
import 'package:practica2/views/card_actor_view.dart';
import 'package:practica2/views/card_trailer_view.dart';
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
    final dbHelper = DatabaseNotes().database;
  ApiTrailer? apiTrailer;
  ApiActors? apiActors;
  @override
  void initState() {
    super.initState();
    dbNotes = DatabaseNotes();
    apiTrailer=ApiTrailer();
    apiActors=ApiActors();
    
  }
  
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String title=movie['title'];
    bool res;
    String backdropPath=movie['backdrop_path'];
    final Future<bool> _value=dbNotes.metodo(movie['title']);
    return Scaffold(
      appBar: AppBar(
        title:Text(movie['title']) ,
        actions: <Widget>[
          FutureBuilder<bool>(
            future: _value,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data==false) {
              _isFavorited=true;
            } else {
              _isFavorited=false;
            }
            return IconButton(
             icon: 
               (_isFavorited
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border)),
             color: Colors.red[500],
             onPressed: (){
              if (_isFavorited==true) {
                dbNotes.deleteFav(movie['id']).then((value){
                  if (value==1) {
                        ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                          content: Text('Se elimino correctamente')
                          )
                        );
                      Navigator.pop(context);
                      }
                });  
              } else {
             FavDAO objFav=FavDAO(id_fav: movie['id'],title: movie['title']);
             dbNotes.insertarFavorito(objFav.toMap()).then((value){
             if (value>0) {
                ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text('Agregada'))
             );
             }else{
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text('Error in your request'))
             );
             Navigator.pop(context);
           }
           Navigator.pop(context);
             }); 
              }
             },
           );
          }
          else{
            return IconButton(onPressed: (){}, 
            icon: const Icon(
              (Icons.error)));
          }
          },
          ),
        ]
      ),
      body: Column(
        children: [
          Text('Sinopsis'),
          Text(movie['overview']),
          Expanded(child: 
            FutureBuilder(
            future: apiTrailer!.getAllTrailer(movie['id'].toString()),
            builder: (BuildContext context, 
            AsyncSnapshot<List<TrailerModel>?> snapshot) {
              if (snapshot.hasError) {
                return Text('Ocurrio un error');
              }
              else{
                
                print(snapshot.data);
                if (snapshot.connectionState==ConnectionState.done) {
                  return _TrailerViewMovie(snapshot.data);
                }
                else{

                  return Center(child:CircularProgressIndicator());
                }
              }
              
            },
          ),),
          Expanded(child: FutureBuilder(
            future: apiActors!.getAllActors(movie['id'].toString()),
            builder: (BuildContext context,
             AsyncSnapshot<List<ActorsModel>?> snapshot) {
              if (snapshot.hasError) {
                return Text('no jala');
              }
              else{
                if (snapshot.connectionState==ConnectionState.done) {
                  return _ActorsViewMovie(snapshot.data);
                } else {
                  return CircularProgressIndicator();
                }
              }
            },
          ),)
        ],
      ),
    );
  }

 Widget _TrailerViewMovie(List<TrailerModel>? videos) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            TrailerModel video = videos![index];
            return CardTrailerView(
              trailerModel: video,
            );
          },
          separatorBuilder: (_, __) => Divider(
                height: 10,
              ),
          itemCount: 1),
    );
  }

   Widget _ActorsViewMovie(List<ActorsModel>? actors) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            ActorsModel actor = actors![index];
            return CardActorView(
              actorsModel: actor,
            );
          },
          separatorBuilder: (_, __) => Divider(
                height: 10,
              ),
          itemCount: actors!.length),
    );
  }
  }