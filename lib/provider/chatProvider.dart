import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api.dart';

class DoctorCard {
  final String id;
  final String firstname;
  final String lastname;
  final String picture;
  final bool isFav;
  final String hospital;

  DoctorCard(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.picture,
      required this.isFav,
      required this.hospital});
}

class ChatPreviewCard {
  final String message;
  final String targetID;
  final String firstname;
  final String lastname;
  final String picture;
  ChatPreviewCard({
    required this.message,
    required this.targetID,
    required this.firstname,
    required this.lastname,
    required this.picture,
  });
}

class ChatProvider with ChangeNotifier {
  String? _token;
  // Consult page
  List<DoctorCard> doctorList = [];

  // Chat Page
  List<ChatPreviewCard> chatPreviewList = [];

  // Constructor
  ChatProvider(this._token);

  /*
  *  #############################################
  *  ## Provider functions for the consult page ##
  *  #############################################
  */
  List<DoctorCard> modifyDoctorList(data, bool isFav) {
    List<DoctorCard> docList = [];
    data.forEach((el) {
      docList.add(DoctorCard(
          id: el['id'],
          firstname: el['firstname'],
          lastname: el['lastname'],
          picture: el['picture'],
          isFav: isFav ? true : el['isFav'],
          hospital: el['hospitalName']));
    });

    return docList;
  }

  Future<List<DoctorCard>> getListOfDoctor(bool isFav) async {
    try {
      if (isFav) {
        // Get list of favorite doctors
        final response = await Dio().get(apiEndpoint + '/chat/fav-doctors',
            options:
                Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
        doctorList = modifyDoctorList(response.data, true);
      } else {
        // Get list of all doctors
        final response = await Dio().get(apiEndpoint + '/chat/doctors',
            options:
                Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
        doctorList = modifyDoctorList(response.data, isFav);
      }
      notifyListeners();
    } catch (err) {
      print(err);
    }
    return doctorList;
  }

  Future<void> onChangeFavorite(String doctorId, bool isFav) async {
    try {
      if (isFav) {
        final request = await Dio().post(apiEndpoint + '/chat/fav-doctor',
            data: {"doctorID": doctorId},
            options:
                Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
      } else {
        final request = await Dio().delete(apiEndpoint + '/chat/unfav-doctor',
            data: {"doctorID": doctorId},
            options:
                Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
      }

      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  /* 
  *  ##########################################
  *  ## Provider functions for the chat page ##
  *  ##########################################
  */
  List<ChatPreviewCard> modifyChatPreviewList(data) {
    List<ChatPreviewCard> chatList = [];
    data.forEach((el) {
      chatList.add(
        ChatPreviewCard(
            targetID: el['targetID'],
            firstname: el['firstname'],
            lastname: el['lastname'],
            picture: el['picture'],
            message: el['message']),
      );
    });

    return chatList;
  }

  Future<List<ChatPreviewCard>> getListOfChatPreview() async {
    try {
      final response = await Dio().get(apiEndpoint + '/chat/preview',
          options:
              Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
      chatPreviewList = modifyChatPreviewList(response.data);
      notifyListeners();
    } catch (err) {
      print(err);
    }
    return chatPreviewList;
  }
}
