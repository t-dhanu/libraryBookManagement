import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp/models/book.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get books from Firestore
  Future<List<Book>> fetchBooksByGenre(String genre) async {
    QuerySnapshot snapshot = await firestore
        .collection('books')
        .where('genre', isEqualTo: genre)
        .get();
    return snapshot.docs.map((doc) {
      return Book.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  // Add a new book to Firestore
  Future<void> addBook(Book book) async {
    await firestore.collection('books').add(book.toMap());
  }

  // Update book availability
  Future<void> updateBookAvailability(String bookId, bool isAvailable) async {
    await firestore.collection('books').doc(bookId).update({
      'isAvailable': isAvailable,
    });
  }
}
