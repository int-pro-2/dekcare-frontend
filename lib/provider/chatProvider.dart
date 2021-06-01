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

class ChatProvider with ChangeNotifier {
  String? _token;
  // Consult page
  List<DoctorCard> doctorList = [];

  // Chat Page
  List<ChatRoomPreview> chatPreview = [];

  // Constructor
  ChatProvider(this._token);

  /*
  * Provider for the consult page
  */
  List<DoctorCard> modifyDoctorList(data, fav) {
    List<DoctorCard> doctorList = [];

    data.forEach((el) {
      doctorList.add(DoctorCard(
          id: el['id'],
          firstname: el['firstname'],
          lastname: el['lastname'],
          picture: el['picture'],
          isFav: el['isFav'] ?? fav,
          hospital: el['birthdate']));
    });

    return doctorList;
  }

  Future<List<DoctorCard>> getListOfDoctor(bool isFav) async {
    try {
      if (isFav) {
        final response = await Dio().get(apiEndpoint + '/chat/fav-doctors',
            options:
                Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
        doctorList = modifyDoctorList(response.data, isFav);
        notifyListeners();
      } else {
        final response = await Dio().get(apiEndpoint + '/chat/doctors',
            options:
                Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
        doctorList = modifyDoctorList(response.data, isFav);
        notifyListeners();
      }
    } catch (err) {
      print(err);
    }
    return doctorList;
  }

  Future<void> onChangeFavorite(String doctorId, bool isFav) async {
    try {
      if (isFav) {
        print("This is favorite");
        final request = await Dio().post(apiEndpoint + '/chat/fav-doctor',
            data: {"doctorID": doctorId},
            options:
                Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
        print("Done unfavorite the doctor");
      } else {
        print("This is unfavorite");
        final request = await Dio().post(apiEndpoint + '/chat/unfav-doctor',
            data: {"doctorID": doctorId},
            options:
                Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
        print("Done favorite the doctor");
      }
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }
}
