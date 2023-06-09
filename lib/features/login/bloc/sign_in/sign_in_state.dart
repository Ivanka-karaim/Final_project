import 'package:flutter/material.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInSuccessful extends SignInState {}

class SignInPhoneNumberError extends SignInState {}

class SignInPasswordError extends SignInState {}

class SignInPhoneNumberSuccessful extends SignInState {}

class SignInError extends SignInState {
  final String error;

  SignInError({required this.error});
}
