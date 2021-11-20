import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/home.dart';
import 'package:flutter_firebase_app/pages/login.dart';
import 'package:flutter_firebase_app/pages/signup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  Future<FirebaseApp>_initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return FutureBuilder(
       future: _initialization,
       builder: (context, snapshot){
         if(snapshot.hasError){
           print("Something went wrong");
         }
         if(snapshot.connectionState == ConnectionState.waiting){
           return Center(child: CircularProgressIndicator());
         }
         return MaterialApp(
           title: 'Flutter Demo',
debugShowCheckedModeBanner: false,
           home: Signup(),
         );
       }
       );
  }
}

