import 'package:flutter/material.dart';
import 'package:practica2/routes/routes.dart';
import 'package:practica2/screens/login.dart';
import 'package:practica2/settings/settings_color.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
       navigateRoute: Login(),
      duration: 5000,
      imageSize: 130,
      imageSrc: "assets/spider.png",
      text: "Splash Screen",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: SettingsColor.backColor,
    );
  }
}