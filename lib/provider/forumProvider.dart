import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api.dart';

class Forum {
  final int id;
  final String ownerID;
  final String displayname;
  final String topic;
  final String body;
  final DateTime date;
  final int count;
  final String picture;

  Forum(
      {required this.id,
      required this.ownerID,
      required this.topic,
      required this.body,
      required this.date,
      required this.displayname,
      required this.count,
      required this.picture});
}

class ForumProvider with ChangeNotifier {
  String _token;
  List<Forum> _forums = [];
  ForumProvider(this._token, this._forums);
  List<Forum> get forums {
    return _forums;
  }

  Future<void> fetchForums() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) return;
    String token = prefs.getString('userToken').toString();
    _token = token;
    try {
      print("tokne in provider" + token);
      final response = await Dio().get(apiEndpoint + '/forum/forums',
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      _forums = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<Forum> modifyResponse(List<dynamic> data) {
    List<Forum> forums = [];
    data.forEach(
      (el) => {
        forums.add(Forum(
            id: el["id"],
            ownerID: el["ownerID"],
            topic: el["topic"],
            body: el["body"],
            date: DateTime.parse(el["date"]),
            displayname: el["displayname"],
            count: el["count"],
            picture: el["picture"].toString())),
      },
    );
    return forums;
  }
}
