import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testapp/models/book.dart';

class BookCatalogPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  Future<List<Book>> getBooks(String genre) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('genre', isEqualTo: genre)
        .get();
    return snapshot.docs.map((doc) {
      return Book.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Catalog")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search by Genre",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Trigger search functionality
                  },
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Book>>(
                future: getBooks(searchController.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No books found"));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Book book = snapshot.data![index];
                      return ListTile(
                        title: Text(book.title),
                        subtitle: Text(book.author),
                        trailing: Icon(
                          book.isAvailable ? Icons.check : Icons.clear,
                          color: book.isAvailable ? Colors.green : Colors.red,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
