import 'package:flutter/material.dart';

@immutable
abstract class SignInEvent {}

class PhoneNumberEvent extends SignInEvent {
  String? phoneNumber;

  PhoneNumberEvent({this.phoneNumber});
}

class AuthorizationEvent extends SignInEvent {
  String? password;

  AuthorizationEvent({this.password});
}
