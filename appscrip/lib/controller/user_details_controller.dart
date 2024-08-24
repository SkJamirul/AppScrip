import 'dart:convert';
import 'package:appscrip/Home/model/user_api_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class UserDetailsController {
  final String link = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserApiResModel>> get fetchUserListData => _fetchUserListData();
//get the user data as a list , controller function
  Future<List<UserApiResModel>> _fetchUserListData() async {
    List<UserApiResModel> users = [];
    try {
      final response = await apiGet(link);
      users = (response as List)
          .map((user) => UserApiResModel.fromJson(user))
          .toList();
      debugPrint('user data fetch successful');
    } catch (e) {
      debugPrint('----user data fetch error : $e');
    }
    return users;
  }

// function to get the api response as a json formate and decode
  Future<dynamic> apiGet(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (kDebugMode) {
        debugPrint(' Api Res ----: ${response.body}');
      }

      return jsonDecode(response.body.toString());
    } catch (e) {
      debugPrint('---- Api error in user details: $e');
    }
  }
}
