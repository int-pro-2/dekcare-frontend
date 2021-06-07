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
  bool isDoctor;
  bool privilege;

  User({
    required this.firstname,
    required this.lastname,
    required this.picture,
    required this.birthdate,
    required this.money,
    required this.isDoctor,
    required this.privilege,
  });
}

class AuthenticateProvider with ChangeNotifier {
  String _token = "";
  User _user = User(
      firstname: '',
      lastname: '',
      picture: '',
      birthdate: DateTime.now(),
      money: 0,
      isDoctor: false,
      privilege: false);

  AuthenticateProvider();
  bool get isAuth {
    return _token.length != 0;
  }

  String get token {
    return _token;
  }

  User get user {
    return _user;
  }

  User modifyUserData(response) {
    return User(
        firstname: response.data['firstname'],
        lastname: response.data['lastname'],
        picture: response.data['picture'],
        birthdate: DateTime.parse(response.data['birthdate']),
        money: response.data['money'],
        isDoctor: response.data['isDoctor'],
        privilege: response.data['privilege']);
  }

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await Dio().post(apiEndpoint + '/auth/login',
          data: {"email": email, "password": password});
      final token = response.data["token"];
      _token = token;
      final res = await Dio().get(apiEndpoint + '/auth/profile',
          options: Options(headers: {"cookie": 'jwt=' + _token + ';'}));

      _user = modifyUserData(res);
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
      final res = await Dio().get(apiEndpoint + '/auth/profile',
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      _user = modifyUserData(res);
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

  Future<void> updateProfilePicture(String pictureURL) async {
    try {
      await Dio().patch(apiEndpoint + '/auth/profile-picture',
          data: {"pictureURL": pictureURL},
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      Timer(Duration(milliseconds: 500), () => notifyListeners());
    } catch (error) {
      throw HttpException(generalException);
    }
  }

  Future<void> addMoney(int money) async {
    try {
      await Dio().post(apiEndpoint + '/bank/add-money',
          data: {"money": money},
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      Timer(Duration(milliseconds: 500), () => notifyListeners());
    } catch (error) {
      throw HttpException(generalException);
    }
  }

  Future<void> withdrawMoney(int money) async {
    try {
      await Dio().post(apiEndpoint + '/bank/withdraw',
          data: {"money": money},
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      Timer(Duration(milliseconds: 500), () => notifyListeners());
    } catch (error) {
      throw HttpException(generalException);
    }
  }

  Future<void> transferMoney(int money, String email) async {
    try {
      await Dio().post(apiEndpoint + '/bank/transfer',
          data: {"money": money, "email": email},
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      Timer(Duration(milliseconds: 500), () => notifyListeners());
    } catch (error) {
      throw HttpException(generalException);
    }
  }
}
