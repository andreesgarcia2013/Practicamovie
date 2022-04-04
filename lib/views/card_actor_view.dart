import 'package:flutter/material.dart';
import 'package:practica2/models/actors_model.dart';

class CardActorView extends StatelessWidget {
  CardActorView({Key? key,this.actorsModel}) : super(key: key);
  ActorsModel? actorsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [
              Container(width: 130,height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage('http://image.tmdb.org/t/p/w780/${actorsModel!.profilePath}')
                
                )
              ),
              ),
              Text(actorsModel!.name!)
            ],  
          ),
        ),
      ),
    );
  }
}