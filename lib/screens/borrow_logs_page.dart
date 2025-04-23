import 'package:flutter/material.dart';

class BorrowLogsPage extends StatelessWidget {
  final List<Map<String, dynamic>> logs;

  BorrowLogsPage({required this.logs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Borrow/Return Logs")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: logs.isEmpty
            ? Center(child: Text("No logs available"))
            : ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log = logs[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        '${log['bookTitle']} - ${log['action']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Timestamp: ${log['timestamp']}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
