import 'package:flutter/material.dart';

@immutable
abstract class ProfileEvent {}

class GetUserEvent extends ProfileEvent{
  // String? accessToken;
  //
  // GetUser({required this.accessToken});
}

class ChangeUserEvent extends ProfileEvent{

}

class GetUserTicketsEvent extends ProfileEvent{}


