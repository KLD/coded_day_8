import 'dart:io';

import 'package:book_api/client.dart';
import 'package:book_api/models/book_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// "https://coded-books-api-crud.herokuapp.com/books"
class BookProvider extends ChangeNotifier {
  List<Book> books = [];
  bool isLoading = false;

  BookProvider() {
    loadBooks();
  }

  Future<void> loadBooks() async {
    isLoading = true;
    notifyListeners();

    books.clear();

    var response = await Client.dio.get("/books");

    var bookJsonList = response.data as List;
    // for (int i = 0; i < bookJsonList.length; i++) {
    //   var bookJson = bookJsonList[i] as Map;
    //   var book = Book(
    //     id: bookJson['id'],
    //     title: bookJson['title'],
    //     description: bookJson['description'],
    //     image: bookJson['image'],
    //     price: bookJson['price'].toString(),
    //   );

    //   books.add(book);
    // }

    // books = bookJsonList
    //     .map((bookJson) => Book(
    //           id: bookJson['id'],
    //           title: bookJson['title'],
    //           description: bookJson['description'],
    //           image: bookJson['image'],
    //           price: bookJson['price'].toString(),
    //         ))
    //     .toList();
    books = bookJsonList.map((bookJson) => Book.fromMap(bookJson)).toList();

    books.sort((a, b) => a.title.compareTo(b.title));

    isLoading = false;

    notifyListeners();
  }

  Future<void> addBook({
    required String title,
    required String description,
    required String price,
    required File image,
  }) async {
    var response = await Client.dio.post("/books",
        data: FormData.fromMap({
          "title": title,
          "description": description,
          "price": price,
          "image": await MultipartFile.fromFile(image.path),
        }));

    loadBooks();
  }

  Future<void> editBook({
    required int id,
    required String title,
    required String description,
    required String price,
    required File image,
  }) async {
    var response = await Client.dio.put("/books/${id}",
        data: FormData.fromMap({
          "title": title,
          "description": description,
          "price": price,
          "image": await MultipartFile.fromFile(image.path),
        }));

    loadBooks();
  }

  void deleteBook(int id) async {
    await Client.dio.delete('/books/$id');

    loadBooks();
  }
}
