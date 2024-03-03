import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;


class ApiService {

  List<UserModel> userModelFromJson(String str) =>
      List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));


  Future<List<UserModel>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<UserModel> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

class ApiConstants {
  static String baseUrl = 'https://jsonplaceholder.typicode.com';
  static String usersEndpoint = '/users';
}


class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,

    required this.phone,
    required this.website,

  });

  int id;
  String name;
  String username;
  String email;

  String phone;
  String website;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],

    phone: json["phone"],
    website: json["website"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,

    "phone": phone,
    "website": website,

  };
}

