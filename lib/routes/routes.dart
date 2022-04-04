import 'package:flutter/material.dart';
import 'package:practica2/screens/about_us_screen.dart';
import 'package:practica2/screens/fruitapp_screen.dart';
import 'package:practica2/screens/list_fav_screen.dart';
import 'package:practica2/screens/notes_screen.dart';

import '../screens/add_notes_sreen.dart';
import '../screens/detail_movie_screen.dart';
import '../screens/popular_screen.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
return <String, WidgetBuilder>{
  '/fruit':(BuildContext context) => FruitApp(),
  '/notes':(BuildContext context) => NotesScreen(),
  '/add':(BuildContext context) => AddNotesScreen(),
  '/movies':(BuildContext context) => PopularScreen(),
  '/details':(BuildContext context)=> DetailMovieScreen(),
  '/about':(BuildContext context) =>  AboutUsScreen(),
  '/listFav':(BuildContext context) => ListFavScreen()
  //'/convert':(BuildContext context) => Conversor()
};
}