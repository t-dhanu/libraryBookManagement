// lib/models/custom_user.dart

import 'package:firebase_auth/firebase_auth.dart';

class CustomUser {
  final String uid;
  final String email;
  final String username;

  CustomUser({
    required this.uid,
    required this.email,
    required this.username,
  });

  // Factory constructor to convert Firebase User to CustomUser
  factory CustomUser.fromFirebaseUser(User user) {
    return CustomUser(
      uid: user.uid,
      email: user.email ?? '',  // Email might be null in rare cases
      username: '',  // You can set this later from Firestore or another source
    );
  }

  // Optionally, you can add methods to update the username from Firestore
  // or other sources if necessary.
}
