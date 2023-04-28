import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {}

class SaveUserEvent extends AuthEvent{
  String? accessToken;

  SaveUserEvent({required this.accessToken});
}

class CheckUserEvent extends AuthEvent{

}