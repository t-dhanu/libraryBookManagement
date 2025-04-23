class Book {
  final String id;
  final String title;
  final String genre;
  final String author;
  final bool isAvailable;

  Book({
    required this.id,
    required this.title,
    required this.genre,
    required this.author,
    required this.isAvailable,
  });

  // Convert a book to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'genre': genre,
      'author': author,
      'isAvailable': isAvailable,
    };
  }

  // Create a book from a Firestore document
  factory Book.fromFirestore(Map<String, dynamic> firestore) {
    return Book(
      id: firestore['id'],
      title: firestore['title'],
      genre: firestore['genre'],
      author: firestore['author'],
      isAvailable: firestore['isAvailable'],
    );
  }
}
