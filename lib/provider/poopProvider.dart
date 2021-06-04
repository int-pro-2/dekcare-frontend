import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/api.dart';

class PoopColor {
  final int id;
  final String color;
  final String code;
  PoopColor({required this.id, required this.color, required this.code});
}

class PoopType {
  final int id;
  final String text;
  PoopType({required this.id, required this.text});
}

class PoopResult {
  final String typeHeader;
  final String typeCode;
  final String typeBody;
  final String colorHeader;
  final String colorCode;
  final String colorBody;
  PoopResult({
    required this.typeHeader,
    required this.typeCode,
    required this.typeBody,
    required this.colorHeader,
    required this.colorCode,
    required this.colorBody,
  });
}

class PoopProvider with ChangeNotifier {
  String? _token;
  List<PoopColor> _colors = [];
  List<PoopType> _types = [];
  PoopResult? _poopAnswer;
  PoopProvider(this._token, this._colors, this._types, this._poopAnswer);

  List<PoopColor> get colors {
    return _colors;
  }

  List<PoopType> get types {
    return _types;
  }

  PoopResult? get poopAnswer {
    return _poopAnswer;
  }

  Future<void> addPoopInfo(int typeID, int colorID, String dateTime) async {
    try {
      final response = await Dio().post(apiEndpoint + '/poop' + '/poop',
          data: {
            "typeID": typeID,
            "colorID": colorID,
            "dateTime": dateTime,
          },
          options: Options(
            headers: {"cookie": 'jwt=' + _token.toString() + ';'},
          ));
      _poopAnswer = PoopResult(
        typeHeader: response.data['type']['header'],
        typeCode: response.data['type']['code'],
        typeBody: response.data['type']['body'],
        colorHeader: response.data['color']['header'],
        colorCode: response.data['color']['code'],
        colorBody: response.data['color']['body'],
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchData() async {
    try {
      print('provider');
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
