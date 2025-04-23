import 'package:flutter/material.dart';
import 'package:testapp/models/custom_user.dart';
import 'package:testapp/screens/borrow_logs_page.dart';

class BooksPage extends StatefulWidget {
  final CustomUser user;

  BooksPage({required this.user});

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final TextEditingController bookController = TextEditingController();
  List<Map<String, dynamic>> books = [];
  List<Map<String, dynamic>> borrowLogs = [];

  void addBook(String title) {
    if (title.isNotEmpty) {
      setState(() {
        books.add({'title': title, 'isRead': false});
        bookController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a book title')),
      );
    }
  }

  void toggleRead(int index, bool returnBook) {
    setState(() {
      books[index]['isRead'] = returnBook;
      addBorrowLog(
        books[index]['title'],
        returnBook ? 'Returned' : 'Borrowed',
      );
    });
  }

  void removeBook(int index) {
    setState(() {
      books.removeAt(index);
    });
  }

  void addBorrowLog(String bookTitle, String action) {
    setState(() {
      borrowLogs.add({
        'bookTitle': bookTitle,
        'action': action,
        'timestamp': DateTime.now(),
      });
    });
  }

  void showBorrowReturnDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Choose Action'),
        content: Text('Do you want to mark this book as borrowed or returned?'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              toggleRead(index, false);
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Borrow'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          ),
          ElevatedButton.icon(
            onPressed: () {
              toggleRead(index, true);
              Navigator.pop(context);
            },
            icon: Icon(Icons.check),
            label: Text('Return'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.book, color: Colors.deepPurple),
            ),
            SizedBox(width: 10),
            Text(
              'Welcome, ${widget.user.username}',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field
            TextField(
              controller: bookController,
              decoration: InputDecoration(
                labelText: 'Enter Book Title',
                prefixIcon: Icon(Icons.book),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add, color: Colors.deepPurple),
                  onPressed: () => addBook(bookController.text),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Book list
            Expanded(
              child: books.isEmpty
                  ? Center(child: Text('No books added yet.'))
                  : ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    book['title'],
                                    style: TextStyle(
                                      decoration: book['isRead']
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Chip(
                                  label: Text(
                                    book['isRead'] ? 'Returned' : 'Borrowed',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: book['isRead']
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removeBook(index),
                            ),
                            onTap: () => showBorrowReturnDialog(index),
                          ),
                        );
                      },
                    ),
            ),

            // View logs button
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.history),
              label: Text('View Borrow/Return Logs'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BorrowLogsPage(logs: borrowLogs),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
