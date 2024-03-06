import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temtech/controller.dart';

import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAq1VikbfgzTU6twuZ-8PU8HbqQUeZNeII",
          authDomain: "fir-21d33.firebaseapp.com",
          appId: "1:539130884965:web:97d4e0b3d5cb0c77be678c",
          messagingSenderId: "539130884965",
          storageBucket: "fir-21d33.appspot.com",
          projectId: "fir-21d33",
          measurementId: "G-1Z3VC367XY"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>ImageController(context),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
