import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book List")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push("/add");
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text("BookList"),
      ),
    );
  }
}
