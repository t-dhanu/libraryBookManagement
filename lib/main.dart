import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testapp/screens/home_page.dart';
import 'package:testapp/screens/sign_up_page.dart';
//rimport 'package:testapp/screens/login_page.dart';
import 'package:testapp/screens/borrow_logs_page.dart';
import 'package:testapp/screens/book_page.dart'; 
import 'package:testapp/models/custom_user.dart';
 // Make sure this import is present
  // Import BorrowLogsPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBeHMIVQDw4ilfHzgtH4Ap8qu0KiPgLUXQ",
      authDomain: "library-management-9e110.firebaseapp.com",
      projectId: "library-management-9e110",
      storageBucket: "library-management-9e110.appspot.com",
      messagingSenderId: "754137437447",
      appId: "1:754137437447:web:bf17ba29c7ff9fef6921a2",
      measurementId: "G-N1L8CKKXT2",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Management App',
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),  // <-- Launch directly into the SignUpPage
    );
  }
}
  

