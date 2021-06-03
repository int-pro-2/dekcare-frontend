import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../config/string.dart';
import '../config/api.dart';
import '../model/httpException.dart';

class User {
  String firstname;
  String lastname;
  String picture;
  DateTime birthdate;
  int money;

  User({
    required this.firstname,
    required this.lastname,
    required this.picture,
    required this.birthdate,
    required this.money,
  });
}

class AuthenticateProvider with ChangeNotifier {
  String _token = "";
  User? _user = null;

  AuthenticateProvider();
  bool get isAuth {
    return _token.length != 0;
  }

  String get token {
    return _token;
  }

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await Dio().post(apiEndpoint + '/auth/login',
          data: {"email": email, "password": password});
      final token = response.data["token"];
      _token = token;
      prefs.setString('userToken', _token);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> register(String email, String password, String firstname,
      String lastname, String birthdate) async {
    try {
      final response = await Dio().post(apiEndpoint + '/auth/register', data: {
        "email": email,
        "password": password,
        "firstname": firstname,
        "lastname": lastname,
        "birthdate": birthdate
      });
      notifyListeners();
    } catch (error) {
      throw HttpException(usedEmailException);
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) return;

    String token = prefs.getString('userToken').toString();
    _token = token;
    try {
      await Dio().get(apiEndpoint + '/auth/profile',
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      notifyListeners();
    } catch (error) {
      prefs.clear();
      _token = "";
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = "";
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> changePassword(String password, String newPassword) async {
    print(password + ' ' + newPassword);
    try {
      await Dio().patch(apiEndpoint + '/auth/change-password',
          data: {"password": password, "newPassword": newPassword},
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      Timer(Duration(milliseconds: 500), () => notifyListeners());
    } catch (error) {
      throw HttpException(generalException);
    }
  }
}
