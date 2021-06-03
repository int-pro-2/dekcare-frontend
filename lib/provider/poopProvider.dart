import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api.dart';

class PoopColor {
  final int id;
  final String color;
  final String code;
  PoopColor({required this.id, required this.color, required this.code});
}

class PoopType {
  final String id;
  final String text;
  PoopType({required this.id, required this.text});
}

class PoopProvider with ChangeNotifier {
  String? _token;
  List<PoopColor> _colors = [];
  List<PoopType> _types = [];
  PoopProvider(this._token, this._colors, this._types);

  List<PoopColor> get colors {
    return _colors;
  }

  List<PoopType> get types {
    return _types;
  }

  Future<void> fetchData() async {
    try {
      final colorResponse = await Dio().get(apiEndpoint + '/poop/color');
      final typeResponse = await Dio().get(apiEndpoint + '/poop/type');
      _colors = modifyResponsePoopColor(colorResponse.data.toList());
      _types = modifyResponsePoopType(typeResponse.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<PoopColor> modifyResponsePoopColor(List<dynamic> data) {
    List<PoopColor> answer = [];
    data.forEach((el) {
      answer.add(PoopColor(id: el['id'], color: el['color'], code: el['code']));
    });
    return answer;
  }

  List<PoopType> modifyResponsePoopType(List<dynamic> data) {
    List<PoopType> answer = [];
    data.forEach((el) {
      answer.add(PoopType(id: el['id'], text: el['text']));
    });
    return answer;
  }
}
