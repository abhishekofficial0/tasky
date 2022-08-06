import 'package:flutter/material.dart';
import 'package:task_app/user/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyDdeZIAKmhVQZbPDt5cLFZ4RkuqHZrrLa4',
        appId: '1:537194666877:android:3df0ecd18cc49c9f84ca14',
        messagingSenderId: '537194666877',
        projectId: 'task-2fdd6'),
  );
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
