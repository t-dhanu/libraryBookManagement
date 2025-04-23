// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:testapp/screens/book_page.dart';  // Import BooksPage
// import 'package:testapp/models/custom_user.dart'; // Import CustomUser model

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Future<void> login() async {
//     try {
//       // Sign in the user with email and password
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );

//       // Convert Firebase User to CustomUser
//       CustomUser customUser = CustomUser.fromFirebaseUser(userCredential.user!);

//       // Navigate to the Books Page if login is successful
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => BooksPage(user: customUser)),
//       );
//     } catch (e) {
//       // Show error message if login fails
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Login Failed: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: "Email"),
//             ),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: "Password"),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text("Login"),
//               onPressed: login,
//             ),
//             SizedBox(height: 10),
//             TextButton(
//               onPressed: () {
//                 Navigator.pushReplacementNamed(context, '/sign_up');
//               },
//               child: Text("Don't have an account? Sign Up"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
