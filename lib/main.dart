
import 'package:exam2/AddWorkout.dart';
import 'package:exam2/WorkoutLogin.dart';
import 'package:exam2/Workout_register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ViewWorkout.dart';
import 'newHome.dart';


void main() async{

WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(

  options: FirebaseOptions(
      apiKey: "AIzaSyCwpBcjNPKhXt9iyfuzdkhKsaVHIztUCX0",
      projectId: "exampractise02",
      messagingSenderId: "862435494699",
      appId: "1:862435494699:web:3d595a7ba2f7f3727b536e"

  )

);

runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: Addstudent(),
      home: AddWorkout(),
     //home: HomePage(),
     //home: ViewWorkout(),
      //home: WorkoutLogin(),


    );
  }
}







