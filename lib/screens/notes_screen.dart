import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/database/database_helper.dart';
import 'package:practica2/models/notes_Model.dart';
import 'package:practica2/screens/add_notes_sreen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late DatabaseNotes dbNotes;

  @override
  void initState(){
    super.initState();
    dbNotes=DatabaseNotes();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Notes'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add').whenComplete(() {
                  setState(() {});
                });
              },
              icon: Icon(Icons.note_add))
        ],
      ),
      body: FutureBuilder(
        future: dbNotes.getAllNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<NotesDAO>> snapshot){
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error al ejecutar'),);
          }else{
            if (snapshot.connectionState==ConnectionState.done) {
              return  _listNotes(snapshot.data!);
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
        }
        ),
    );
  }
  Widget _listNotes(List<NotesDAO> notes){
    return ListView.builder(itemBuilder: (context,index){
      return ListTile(
        title: Text(notes[index].titulo!),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
               MaterialPageRoute(builder: (context) =>
                AddNotesScreen(objNote: notes[index]))).whenComplete(() => (){
                  setState(() {});
                });
          }, icon: Icon(Icons.edit)),
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text('mensaje de la app'),
                content: Text('¿Estas seguro de borrar este elemento?'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                    dbNotes.delete(notes[index].id_nota!).then((value){
                      if (value==1) {
                        ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                          content: Text('Se elimino correctamente')
                          )
                        );

                      }
                    });
                  }, child: Text('Si')),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('No')),
                ],
              );
            });
          }, icon: Icon(Icons.delete))
          ],
        ),
      );
    },
    itemCount: notes.length ,);
  }
}