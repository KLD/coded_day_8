import 'dart:io';

import 'package:book_api/client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? username;

  Future<bool> signup({
    required String username,
    required String password,
  }) async {
    try {
      var response = await Client.dio.post("/signup", data: {
        'username': username,
        'password': password,
      });

      var token = response.data["token"];

      Client.dio.options.headers[HttpHeaders.authorizationHeader] =
          "Bearer $token";

      this.username = username;

      var pref = await SharedPreferences.getInstance();
      await pref.setString("token", token);

      return true;
    } on DioError catch (e) {
      print(e.response!.data);
    } catch (e) {
      print("Unknown Error");
    }

    return false;
  }

  Future<bool> hasToken() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    if (token == null || JwtDecoder.isExpired(token)) {
      return false;
    }

    var tokenMap = JwtDecoder.decode(token);
    username = tokenMap['username'];
    return true;
  }
}
