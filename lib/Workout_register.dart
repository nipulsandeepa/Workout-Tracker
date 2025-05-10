import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam2/AddWorkout.dart';
import 'package:exam2/WorkoutLogin.dart';
import 'package:exam2/newHome.dart';
import 'package:flutter/material.dart';
//
// class WorkoutRegister extends StatefulWidget {
//   const WorkoutRegister({super.key});
//
//   @override
//   State<WorkoutRegister> createState() => _WorkoutRegisterState();
// }
//
// class _WorkoutRegisterState extends State<WorkoutRegister> {
//   TextEditingController firstnameController = TextEditingController();
//   TextEditingController lastnameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController cpasswordController = TextEditingController();
//
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//
//
//   void Add() async {
//     if (firstnameController.text.isNotEmpty &&
//         lastnameController.text.isNotEmpty &&
//         emailController.text.isNotEmpty &&
//         passwordController.text.isNotEmpty &&
//         cpasswordController.text.isNotEmpty) {
//
//       if (passwordController.text == cpasswordController.text) {
//         // Query Firestore to check if the email already exists
//         var existingUser = await firestore
//             .collection('workoutRegister')
//             .where('email', isEqualTo: emailController.text)
//             .get();
//
//         if (existingUser.docs.isNotEmpty) {
//           // User already exists, show a message
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("User already registered! Try logging in.")),
//           );
//         } else {
//           // No duplicate, proceed with registration
//           await firestore.collection('workoutRegister').add({
//             'firstname': firstnameController.text,
//             'lastname': lastnameController.text,
//             'email': emailController.text,
//             'password': passwordController.text,
//             'confirmpassword': cpasswordController.text
//           });
//
//           // Show a success pop-up message
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Registration successful! Redirecting...")),
//           );
//
//           // Navigate to the next page
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddWorkout()),
//           );
//         }
//       } else {
//         // Passwords do not match
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Passwords don't match")),
//         );
//       }
//     } else {
//       // Fields are empty
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Empty Fields! Please fill everything.")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Register Page",style: TextStyle(
//           fontSize: 28,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),),
//         centerTitle: true,
//         //backgroundColor: Colors.blueAccent,
//         backgroundColor: Colors.purple.shade800,
//       ),
//       body: Container(
//
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),
//                 Image.asset(
//                   'lib/images/yoga.png',
//                   height: 250,
//                   width: 350,
//                 ),
//                 const SizedBox(height: 20),
//                 _buildTextField(firstnameController, "First Name", Icons.person),
//                 _buildTextField(lastnameController, "Last Name", Icons.person),
//                 _buildTextField(emailController, "Email", Icons.email),
//                 _buildTextField(passwordController, "Password", Icons.lock, isPassword: true),
//                 _buildTextField(cpasswordController, "Confirm Password", Icons.lock, isPassword: true),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: Add,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     backgroundColor: Colors.blueGrey.shade700,
//                   ),
//                   child: const Text(
//                     "Register",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//
//
//                 ElevatedButton(
//
//                   onPressed: ()
//                   {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
//                   },
//                   style: ElevatedButton.styleFrom(
//
//                     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     backgroundColor: Colors.blueGrey.shade700,
//                   ),
//                   child: const Text(
//                     "Home",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                 ),
//
//
//
//
//
//                  SizedBox(height: 20),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const WorkoutLogin()),
//                     );
//                   },
//                   child: const Text(
//                     "Already have an account? Login",
//                     style: TextStyle(color: Colors.black, fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: TextField(
//         controller: controller,
//         obscureText: isPassword,
//         style: const TextStyle(color: Colors.black),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(color: Colors.black),
//           filled: true,
//           //fillColor: Colors.white.withOpacity(0),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//           prefixIcon: Icon(icon, color: Colors.blue),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'AddWorkout.dart'; // Import your AddWorkout screen
// Import your HomePage
import 'WorkoutLogin.dart'; // Import your Login page

class WorkoutRegister extends StatefulWidget {
  const WorkoutRegister({super.key});

  @override
  State<WorkoutRegister> createState() => _WorkoutRegisterState();
}

class _WorkoutRegisterState extends State<WorkoutRegister> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance; // Firebase Authentication instance
  //
  // void registerUser() async {
  //   if (firstnameController.text.isNotEmpty &&
  //       lastnameController.text.isNotEmpty &&
  //       emailController.text.isNotEmpty &&
  //       passwordController.text.isNotEmpty &&
  //       cpasswordController.text.isNotEmpty) {
  //
  //     if (passwordController.text == cpasswordController.text) {
  //       try {
  //         // Check if the email is already registered
  //         var existingUser = await auth.fetchSignInMethodsForEmail(emailController.text);
  //         if (existingUser.isNotEmpty) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text("User already registered! Try logging in.")),
  //           );
  //           return;
  //         }
  //
  //         // Create user with Firebase Authentication
  //         UserCredential userCredential = await auth.createUserWithEmailAndPassword(
  //           email: emailController.text,
  //           password: passwordController.text,
  //         );
  //
  //         // Store additional user details in Firestore
  //         await firestore.collection('workoutUsers').doc(userCredential.user!.uid).set({
  //           'firstname': firstnameController.text,
  //           'lastname': lastnameController.text,
  //           'email': emailController.text,
  //         });
  //
  //         // Show success message and navigate
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("Registration successful! Redirecting...")),
  //         );
  //
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => const AddWorkout()),
  //         );
  //
  //       } catch (e) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("Error: ${e.toString()}")),
  //         );
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Passwords don't match")),
  //       );
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Empty Fields! Please fill everything.")),
  //     );
  //   }
  // }


  void registerUser() async {
    if (firstnameController.text.isNotEmpty &&
        lastnameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        cpasswordController.text.isNotEmpty) {

      if (passwordController.text.length < 6) {
        _showPasswordErrorDialog(); // Show popup if password is too short
        return;
      }

      if (passwordController.text == cpasswordController.text) {
        try {
          var existingUser = await auth.fetchSignInMethodsForEmail(emailController.text);
          if (existingUser.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User already registered! Try logging in.")),
            );
            return;
          }

          UserCredential userCredential = await auth.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          await firestore.collection('workoutUsers').doc(userCredential.user!.uid).set({
            'firstname': firstnameController.text,
            'lastname': lastnameController.text,
            'email': emailController.text,
            'password':passwordController.text,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration successful! Redirecting...")),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AddWorkout()),
          );

        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${e.toString()}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords don't match")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Empty Fields! Please fill everything.")),
      );
    }
  }

  void _showPasswordErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Weak Password",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("Password must be at least 6 characters long."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("OK", style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register Page",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple.shade800,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'lib/images/yoga.png',
                height: 250,
                width: 350,
              ),
              const SizedBox(height: 20),
              _buildTextField(firstnameController, "First Name", Icons.person),
              _buildTextField(lastnameController, "Last Name", Icons.person),
              _buildTextField(emailController, "Email", Icons.email),
              _buildTextField(passwordController, "Password", Icons.lock, isPassword: true),
              _buildTextField(cpasswordController, "Confirm Password", Icons.lock, isPassword: true),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.blueGrey.shade700,
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.blueGrey.shade700,
                ),
                child: const Text(
                  "Home",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WorkoutLogin()),
                  );
                },
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(icon, color: Colors.blue),
        ),
      ),
    );
  }
}
