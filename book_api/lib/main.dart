import 'package:book_api/models/book_model.dart';
import 'package:book_api/pages/add_book_page.dart';
import 'package:book_api/pages/book_list_page.dart';
import 'package:book_api/pages/edit_book_page.dart';
import 'package:book_api/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BookListPage(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => AddBookPage(),
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) => EditBookPage(
        book: state.extra as Book,
      ),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookProvider()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routerConfig: router,
      ),
    );
  }
}
