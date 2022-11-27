import 'package:book_api/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/book_model.dart';

class BookCard extends StatelessWidget {
  final Color? iconColor;
  const BookCard({required this.book, super.key, this.iconColor});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.description),
      leading: Image.network(
        book.image,
      ),
      trailing: Column(
        children: [
          InkWell(
            onTap: () => context.read<BookProvider>().deleteBook(book.id),
            child: Icon(
              Icons.delete,
              color: iconColor ?? Colors.red,
            ),
          ),
          InkWell(
            onTap: () => context.push("/edit", extra: book),
            child: Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
    );
  }
}
