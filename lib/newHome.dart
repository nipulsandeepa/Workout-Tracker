import 'package:exam2/Workout_register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        foregroundColor: Colors.white54,
        centerTitle: true,
        title: const Text('Workout Tracker',style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
      ),
      body: ListView(
         // width: double.infinity,
         // height: double.infinity,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.purple.shade200, Colors.purple.shade700],
        //     // begin: Alignment.topCenter,
        //     // end: Alignment.bottomCenter,
        //   ),
        // ),
children: [
  Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            /*Container(
                    width: 400,
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade200,
                      borderRadius: BorderRadius.circular(20),
                     ),
                  ),*/
            Image.asset(
              'lib/images/home2.png', // Replace with your image
              height: 420,
              width: 420,
            ),
          ],
        ),
        SizedBox(height: 20),
        // Container(
        //   height: 200,
        //   width: 200,
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [Color(0xFF6A11CB),Color(0xFF2575FC)],
        //     ),
        //   ),
        //
        // ),

        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "Make ",
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: "Your Body\n",
                style: TextStyle(color: Colors.black),
              ),

              TextSpan(
                text: "Healthy & Fit",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          child:
            Text(
              "Track your workout progress and stay healthy !",
              textAlign: TextAlign.center,

              style: TextStyle(color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),

        ),

        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WorkoutRegister()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            "Get Started",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    ),
  ),
],

      ),
    );
  }
}
