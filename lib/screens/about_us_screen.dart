import 'dart:math';

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  CameraPosition _position=CameraPosition(target: LatLng(20.5397811,-100.8184395));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(initialCameraPosition: _position),
      floatingActionButton: CircularMenu( 
        startingAngleInRadian: pi,
        endingAngleInRadian: 6.28,
        radius: 80,
        items: [
          CircularMenuItem(onTap: (){},
          icon: Icons.map,
          color: Colors.green,
          ),
          CircularMenuItem(onTap: (){},
          icon: Icons.map_sharp,
          color: Colors.blue,
          ),
          CircularMenuItem(onTap: (){},
          icon: Icons.maps_home_work,
          color: Colors.purple,
          ),
          CircularMenuItem(onTap: (){},
          icon: Icons.maps_ugc,
          color: Colors.orange,
          )
        ],
      ),
    );
  }
}