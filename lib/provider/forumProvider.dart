import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api.dart';

class Replies {
  final int id;
  final int commentID;
  final String userID;
  final String text;
  final String firstname;
  final String picture;
  final String lastname;
  final DateTime date;
  Replies({
    required this.id,
    required this.commentID,
    required this.picture,
    required this.userID,
    required this.text,
    required this.firstname,
    required this.lastname,
    required this.date,
  });
}

class Comments {
  final int id;
  final String userID;
  final String text;
  final String firstname;
  final String lastname;
  final String picture;
  final List<Replies> replies;

  Comments({
    required this.id,
    required this.userID,
    required this.text,
    required this.firstname,
    required this.lastname,
    required this.picture,
    required this.replies,
  });
}

class Forum {
  final int id;
  final String ownerID;
  final String topic;
  final String body;
  final DateTime date;
  final String firstname;
  final String picture;
  final String lastname;
  final List<Comments> comments;

  Forum(
      {required this.id,
      required this.picture,
      required this.ownerID,
      required this.topic,
      required this.body,
      required this.date,
      required this.firstname,
      required this.lastname,
      required this.comments});
}

class UserProfile {
  final String email;
  final String firstname;
  final String lastname;
  final String money;
  final DateTime birthdate;
  final String picture;
  final String isDoctor;

  UserProfile({
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.birthdate,
    required this.money,
    required this.picture,
    required this.isDoctor,
  });
}

class Forums {
  final int id;
  final String ownerID;
  final String displayname;
  final String topic;
  final String body;
  final DateTime date;
  final int count;
  final String picture;

  Forums(
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
  String? _token;
  List<Forums> _forums = [];
  List<Forum> _specificforum = [];
  List<UserProfile> _userProfile = [];

  ForumProvider(
      this._token, this._forums, this._specificforum, this._userProfile);
  List<Forums> get forums {
    return _forums;
  }

  List<Forum> get specificforum {
    return _specificforum;
  }

  List<UserProfile> get userProfile {
    return _userProfile;
  }

  Future<void> fetchForums() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) return;
    String token = prefs.getString('userToken').toString();
    _token = token;
    try {
      final response = await Dio().get(
          apiEndpoint + '/forum/forums?orderBy=lastest',
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      _forums = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<Forums> modifyResponse(List<dynamic> data) {
    List<Forums> forums = [];
    data.forEach(
      (el) => {
        forums.add(Forums(
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

//////////////////////////////////////////////////////
  Future<void> fetchSpecificForum(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) return;
    String token = prefs.getString('userToken').toString();
    _token = token;
    try {
      // print("tokne in provider" + token);
      final response = await Dio().get(apiEndpoint + '/forum/forum/$id',
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));
      _specificforum = modifyResponseSpecificForum(response.data);
      notifyListeners();
      // print(response);
      // print(specificforum[0].comments[1].replies[0].text);
    } catch (error) {
      print(error);
    }
  }

  List<Forum> modifyResponseSpecificForum(data) {
    List<Forum> specificforum = [];
    List<Comments> comments = [];
    List<Replies> replies = [];

    data['comments'].forEach(
      (el) => {
        el['replies'].forEach(
          (el1) => {
            replies.add(Replies(
                id: el1['id'],
                commentID: el1['commentID'],
                userID: el1['userID'],
                text: el1['text'],
                firstname: el1['firstname'],
                lastname: el1['lastname'],
                picture: el1['picture'],
                date: DateTime.parse(el1['date'])))
          },
        )
      },
    );
    data['comments'].forEach(
      (el) => {
        comments.add(Comments(
            id: el['id'],
            userID: el['userID'],
            text: el['text'],
            picture: el['picture'],
            firstname: el['firstname'],
            lastname: el['lastname'],
            replies: replies))
      },
    );

    specificforum.add(Forum(
        id: data["id"],
        ownerID: data["ownerID"],
        picture: data['picture'],
        topic: data["topic"],
        body: data["body"],
        date: DateTime.parse(data["date"]),
        firstname: data['firstname'],
        lastname: data['lastname'],
        comments: comments));
    return specificforum;
  }

  Future<void> createForum(String topic, String body, String date) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await Dio().post(apiEndpoint + '/forum/forum',
          data: {"topic": topic, "body": body, "date": date},
          options:
              Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> createComment(String forumID, String text, String date) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      print(forumID + text + date);
      final response = await Dio().post(apiEndpoint + '/forum/comment',
          data: {"forumID": forumID, "text": text, "date": date},
          options:
              Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
      print('done create comment provider');

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> createReply(String commentID, String text, String date) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      print(commentID + text + date);
      final response = await Dio().post(apiEndpoint + '/forum/reply',
          data: {"commentID": commentID, "text": text, "date": date},
          options:
              Options(headers: {"cookie": 'jwt=' + _token.toString() + ';'}));
      print('done create reply provider');

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) return;
    String token = prefs.getString('userToken').toString();
    _token = token;
    try {
      // print("tokne in provider" + token);
      final response = await Dio().get(apiEndpoint + '/auth/profile',
          options: Options(headers: {"cookie": 'jwt=' + token + ';'}));

      _userProfile = modifyResponseUserProfile(response.data);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<UserProfile> modifyResponseUserProfile(data) {
    List<UserProfile> userProfile = [];

    userProfile.add(UserProfile(
      email: data["email"].toString(),
      firstname: data["firstname"].toString(),
      lastname: data["lastname"].toString(),
      money: data["money"].toString(),
      isDoctor: data['isDoctor'].toString(),
      birthdate: DateTime.parse(data["birthdate"]),
      picture: data["picture"].toString(),
    ));

    return userProfile;
  }
}
