import 'package:book_api/models/book_model.dart';
import 'package:book_api/pages/add_book_page.dart';
import 'package:book_api/pages/book_list_page.dart';
import 'package:book_api/pages/edit_book_page.dart';
import 'package:book_api/pages/signup_page.dart';
import 'package:book_api/providers/auth_provider.dart';
import 'package:book_api/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var authProvider = AuthProvider();

  var isAuth = await authProvider.hasToken();

  print("isAuth $isAuth");

  runApp(MyApp(
    authProvider: authProvider,
    initialRoute: isAuth ? '/list' : "/signup",
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final AuthProvider authProvider;

  MyApp({
    required this.authProvider,
    required this.initialRoute,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: '/signup',
          builder: (context, state) => SignUpPage(),
        ),
        GoRoute(
          path: '/list',
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookProvider()),
        ChangeNotifierProvider(create: (context) => authProvider),
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
