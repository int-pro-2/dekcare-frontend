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
  final DateTime hospital;

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

  List<DoctorCard> modifyDoctorList(data) {
    List<DoctorCard> doctorList = [];

    data.forEach((el) => {
          doctorList.add(DoctorCard(
              id: el['id'],
              firstname: el['firstname'],
              lastname: el['lastname'],
              picture: el['picture'],
              isFav: el['isFav'],
              hospital: el['birthdate']))
        });

    return doctorList;
  }

  Future<List<DoctorCard>> getListOfDoctor() async {
    try {
      final response = await Dio().get(apiEndpoint + '/chat/doctors');
      doctorList = modifyDoctorList(response.data);
      print(response.data);
      notifyListeners();
    } catch (err) {
      print(err);
    }
    return doctorList;
  }
}
