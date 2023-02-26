import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:lost_and_foud/login.dart';
import 'package:lost_and_foud/registration.dart';
import 'package:velocity_x/velocity_x.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
// / Store definition


class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
   CollectionReference users = FirebaseFirestore.instance.collection('users');
  // const MyApp({super.key});
  static const String _title = 'lost and found app';
    Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': "sky", // John Doe
          'company': "sky", // Stokes and Sons
          'age': 12 // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,                                  

      home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("you have an error ${snapshot.error.toString()}");
              return Text("netwotk error");
            } else if (snapshot.hasData) {
              return SimpleLoginScreen();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),

      // MyStatefulWidget(),
    );
  }
}


/*
  Flutter UI
  ----------
  lib/screens/simple_login.dart
*/

