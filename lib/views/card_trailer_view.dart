import 'package:flutter/material.dart';
import 'package:practica2/models/trailer_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CardTrailerView extends StatelessWidget {
  CardTrailerView({Key? key,this.trailerModel}) : super(key: key);
  TrailerModel? trailerModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 5.0),
                blurRadius: 2.5)
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            child: Column(
              children: [
                YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: '${trailerModel!.key}',
                    flags: YoutubePlayerFlags(
                      hideControls: false,
                      controlsVisibleAtStart: true,
                      autoPlay: false,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}