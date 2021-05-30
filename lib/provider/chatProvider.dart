import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api.dart';

class ChatRoomPreview {
  final String doctorFirstName;
  final String doctorLastName;
  final String latestMessages;
  final String doctorPicture;

  ChatRoomPreview(
      {required this.doctorFirstName,
      required this.doctorLastName,
      required this.doctorPicture,
      required this.latestMessages});
}

class ChatProvider with ChangeNotifier {
  String _token;
  List<ChatRoomPreview> chatPreview;

  ChatProvider(this._token, this.chatPreview);
}
