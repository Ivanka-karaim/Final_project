import 'dart:convert';

import 'package:final_project/data/constants.dart';
import 'package:http/http.dart' as http;


class AuthorizationRepository {
  Future<dynamic> authorization(String? phoneNumber) async {
    final login = await http.post(Uri.parse('$URL_API/api/auth/otp'),
        body: {"phoneNumber": phoneNumber});


    return jsonDecode(login.body);
  }

  Future<dynamic> otpAuthorization(String? phoneNumber, String? otp) async{
    final login = await http.post(Uri.parse('$URL_API/api/auth/login'),
        body: {"phoneNumber": phoneNumber, "otp": otp});
    return jsonDecode(login.body);
  }

  Future<dynamic> getUser(String accessToken) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/user'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    return jsonDecode(response.body);

  }

  Future<dynamic> changeUser(Map<String, Object> json, String accessToken) async {
    final response = await http.post(
      Uri.parse('$URL_API/api/user'),
      body: json,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> getUserTickets(String accessToken) async {

    final response = await http.get(
      Uri.parse('$URL_API/api/user/tickets'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    return jsonDecode(response.body);
  }
}
