import 'package:flutter/material.dart';
import 'package:practica2/database/database_helper.dart';
import 'package:practica2/models/favoritos_model.dart';

class ListFavScreen extends StatefulWidget {
  const ListFavScreen({Key? key}) : super(key: key);

  @override
  State<ListFavScreen> createState() => _ListFavScreenState();
}

class _ListFavScreenState extends State<ListFavScreen> {
  late DatabaseNotes dbNotes;
  bool _isFavorited = true;
  @override
  void initState(){
    super.initState();
    dbNotes=DatabaseNotes();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Favoritos'),
        actions: <Widget>[
          IconButton(onPressed: _toggleFavorite, icon: _isFavorited? const Icon(Icons.star):const Icon(Icons.star_border))
        ],
      ),
      body: FutureBuilder(
        future: dbNotes.getAllFav(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error'),);
          }else{
            if (snapshot.connectionState==ConnectionState.done) {
              return _listFav(snapshot.data!);
            }
            else{
              return Center(child:CircularProgressIndicator());
            }
          }
          },

      ),
    );
  }
  void _toggleFavorite() {
  setState(() {
    if (_isFavorited) {
      _isFavorited = false;
    } else {
      _isFavorited = true;
    }
  });
}
}
Widget _listFav(List<FavDAO> favs){
  return ListView.builder(itemBuilder: (context, index){
    return ListTile(
      title: Text(favs[index].title!),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  },
  itemCount: favs.length,);
}