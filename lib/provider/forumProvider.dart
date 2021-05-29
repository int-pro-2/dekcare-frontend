import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/api.dart';

class Forum {
  final id;
  final ownwerID;
  final userName;
  final topic;
  final body;
  final date;
  final comment;
  final img;

  Forum(
      {this.id,
      this.ownwerID,
      this.topic,
      this.body,
      this.date,
      this.userName,
      this.comment,
      this.img});
}

class ForumProvider with ChangeNotifier {
  ForumProvider();

  Future<void> getForum(context) async {
    try {
      final response = await Dio().get(apiEndpoint + '/forum/forums');
      print(response);
    } catch (error) {
      print(error);
    }
  }
}
