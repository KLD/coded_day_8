import 'package:dio/dio.dart';

class Client {
  static final Dio dio =
      Dio(BaseOptions(baseUrl: "https://coded-books-api-crud.herokuapp.com"));
}
