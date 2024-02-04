import 'dart:async';

import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';

import '../Home/homepage.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  HomeScreen(index: 0,)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Image(image: AssetImage("assets/ponflow.png"),
            width: 200, // set the width of the image
            height: 200, // set the height of the image
            fit: BoxFit.contain,
          ),
        )

      ),
    );
  }
}
