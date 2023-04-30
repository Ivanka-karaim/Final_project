import 'dart:convert';

import 'package:final_project/data/constants.dart';
import 'package:http/http.dart' as http;

import '../models/ticket.dart';
import '../models/user.dart';

class AuthorizationRepository {
  Future<dynamic> authorization(String? phoneNumber) async {
    final login = await http.post(Uri.parse('$URL_API/api/auth/otp'),
        body: {"phoneNumber": phoneNumber});
    // final login = await http.post(Uri.parse('$URL_API/api/auth/login'),
    //     body: {"phoneNumber": phoneNumber, "otp": "0000"});

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

  Future<User> changeUser(Map<String, Object> json, String accessToken) async {
    final response = await http.post(
      Uri.parse('$URL_API/api/user'),
      body: json,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    final user = User.fromJson(jsonDecode(response.body)["data"]);
    print(user);
    return user;
  }

  Future<dynamic> getUserTickets(String accessToken) async {

    final response = await http.get(
      Uri.parse('$URL_API/api/user/tickets'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    return jsonDecode(response.body);
    // for (int i = 0; i < jsonDecode(response.body)["data"].length; i++) {
    //   final ticket = Ticket.fromJson(jsonDecode(response.body)["data"][i]);
    //   tickets.add(ticket);
    // }
    // print(tickets);
    // return tickets;
  }
}
