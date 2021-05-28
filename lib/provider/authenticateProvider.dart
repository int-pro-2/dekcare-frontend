import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../config/string.dart';
import '../config/api.dart';
import '../model/httpException.dart';

class AuthenticateProvider with ChangeNotifier {
  String _token = "";

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

      final temp = await Dio().get(apiEndpoint + '/auth/profile',
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      print('temp is');
      print(temp.data);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await Dio()
          .post('/auth/regis', data: {"email": email, "password": password});
      final token = response.data["token"];
      notifyListeners();
      prefs.setString('userToken', _token);
    } catch (error) {
      prefs.clear();
      throw HttpException(usedEmailException);
    }
  }

  Future<void> tryAutoLogin() async {
    print('Start to try auto login');
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) {
      print('no pref');
      return;
    }

    String token = prefs.getString('userToken').toString();
    print('token is' + token);
    _token = token;
    try {
      final response = await Dio().get(apiEndpoint + '/auth/profile',
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      print(response.data);
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

  Future<void> forgetPassword(String email) async {
    // try {
    //   await Dio().post(apiEndpoint + '/auth/reset', data: {"email": email});
    //   Timer(Duration(milliseconds: 500), () => notifyListeners());
    // } catch (error) {
    //   throw HttpException(invalidException('email'));
    // }
  }

  Future<void> checkResetPassword(String recoveryToken) async {
    // try {
    //   _recoveryToken = recoveryToken;
    //   await Dio().post(apiEndpoint + '/auth/check-token',
    //       data: {"token": recoveryToken});
    //   Timer(Duration(milliseconds: 500), () => notifyListeners());
    // } catch (error) {
    //   throw HttpException(invalidException('token'));
  }
}

Future<void> changePassword(String newPassword) async {
  // try {
  //   await Dio().patch(apiEndpoint + '/auth/reset',
  //       data: {"token": _recoveryToken, "password": newPassword});
  //   Timer(Duration(milliseconds: 500), () => notifyListeners());
  // } catch (error) {
  //   throw HttpException(generalException);
  // }
}
