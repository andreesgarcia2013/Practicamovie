import 'package:flutter/material.dart';
import 'package:practica2/database/database_helper.dart';
import 'package:practica2/models/notes_Model.dart';

class AddNotesScreen extends StatefulWidget {
  NotesDAO? objNote;
  AddNotesScreen({Key? key,this.objNote}) : super(key: key);

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  var txtTitleController = TextEditingController();
  var txtDescController = TextEditingController();
  late DatabaseNotes dbNotes;
  @override
  void initState() {
    super.initState();
    if (widget.objNote != null) {
      txtTitleController.text=widget.objNote!.titulo!;
      txtDescController.text=widget.objNote!.descripcion!;
    }
    dbNotes = DatabaseNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.objNote==null? Text('Add Note'):Text('Edit Note'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/add');
          }, icon: Icon(Icons.note_add))
        ],
        ),
        body: ListView(
          children: [
            _createTextFieldTitle(),
            SizedBox(height: 5,),
            _createTextFieldDesc(),
            SizedBox(height: 5,),
            _createButtonSave()
          ],
        ),
    );
  }

  Widget _createTextFieldTitle() {
    return TextField(
      keyboardType: TextInputType.text,
      controller: txtTitleController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
    );
  }

 Widget _createTextFieldDesc() {
   return TextField(
     keyboardType: TextInputType.text,
     controller: txtDescController,
     maxLines: 8,
     decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      )
   );
 }

Widget  _createButtonSave() {
  return ElevatedButton(
      child: Text('Save Note'),
      onPressed: (){
        if (widget.objNote==null) {
           NotesDAO objNote=NotesDAO(titulo: txtTitleController.text, 
        descripcion: txtDescController.text);
        dbNotes.insertar(objNote.toMap()).then((value){
          if (value>0) {
            Navigator.pop(context);
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error in your request'))
            );
          }
        }); 
        }else{
          widget.objNote!.titulo=txtTitleController.text;
          widget.objNote!.descripcion=txtDescController.text;
          dbNotes.update(widget.objNote!.toMap());
        }
       
      },
    );
}
}