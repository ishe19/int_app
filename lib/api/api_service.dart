import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:int_app/constants/urls.dart';
import 'package:int_app/models/login_model.dart';
import 'package:int_app/models/user_model.dart';

class ApiService {
  Future<UserModel> login(LoginRequestModel requestModel) async {
    String? email = requestModel.email;
    String? password = requestModel.password;
    String url = '$baseUrl/login';

    Map data = {"email": email, "password": password};

    var body = json.encode(data);

    final response = await http.post(Uri.parse(url), body: body, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Headers": "*"
    });

    if (response.statusCode == 200 || response.statusCode == 400) {
      debugPrint("SUCCESS");
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed with code: ${response.statusCode}");
    }
  }

  Future<dynamic> register(UserModel userModel) async {
    String? email = userModel.email;
    String? password = userModel.password;
    String? firstName = userModel.firstName;
    String? lastName = userModel.lastName;
    String? nationality = userModel.nationality;
    String? phoneNumber = userModel.phoneNumber;
    DateTime? dob = userModel.dob;
    String url = '$baseUrl/register';
    // userModel.toJson();

    Map data = {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "dob":
          "${dob!.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
      "nationality": nationality,
      "email": email,
      "password": password
    };

    var body = json.encode(data);

    final response = await http.post(Uri.parse(url),
        // body: requestModel.toJson(),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Access-Control-Allow-Headers": "*"
        });

    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.statusCode;
    } else {
      throw Exception("Failed with code: ${response.statusCode}");
    }
  }
}
