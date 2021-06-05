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

class Poop {
  final String text;
  final String color;
  final String code;
  Poop({required this.text, required this.color, required this.code});
}

class PoopInfoItem {
  final String date;
  final List<Poop> poops;
  final String result;
  final String resultCode;
  PoopInfoItem({
    required this.date,
    required this.poops,
    required this.result,
    required this.resultCode,
  });
}

class PoopProvider with ChangeNotifier {
  String? _token;
  List<PoopColor> _colors = [];
  List<PoopType> _types = [];
  PoopResult? _poopAnswer;
  List<PoopInfoItem> _poopsInfo = [];
  PoopProvider(
    this._token,
    this._colors,
    this._types,
    this._poopAnswer,
    this._poopsInfo,
  );

  List<PoopColor> get colors {
    return _colors;
  }

  List<PoopType> get types {
    return _types;
  }

  PoopResult? get poopAnswer {
    return _poopAnswer;
  }

  List<PoopInfoItem> get poopsInfo {
    return _poopsInfo;
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
      final colorResponse = await Dio().get(apiEndpoint + '/poop/color');
      final typeResponse = await Dio().get(apiEndpoint + '/poop/type');
      _colors = modifyResponsePoopColor(colorResponse.data.toList());
      _types = modifyResponsePoopType(typeResponse.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchPoopInfo(int month, int year) async {
    try {
      String endpoint = '/poop' +
          '/info?month=' +
          month.toString() +
          '&year=' +
          year.toString();
      final response = await Dio().get(apiEndpoint + endpoint,
          options:
              Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
      _poopsInfo = modifyResponsePoopInfo(response.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<PoopInfoItem> modifyResponsePoopInfo(List<dynamic> data) {
    List<PoopInfoItem> answer = [];
    data.forEach((el) {
      List<Poop> tempPoop = [];
      el['poop'].forEach((poop) {
        tempPoop.add(
            Poop(text: poop['text'], color: poop['color'], code: poop['code']));
      });
      answer.add(
        PoopInfoItem(
            date: el['date'],
            poops: tempPoop,
            result: el['result'],
            resultCode: el['resultCode']),
      );
    });
    return answer;
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
