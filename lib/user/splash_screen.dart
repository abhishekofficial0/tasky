import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_app/authentication/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 76, 16, 154),
        child: Center(
          child: Text(
            "TASKY",
            style: TextStyle(
                color: Colors.white, fontSize: 54, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ));
  }
}
