import 'package:final_project/features/session/models/session.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SessionState {}

class SessionInitial extends SessionState {}

class SessionBook extends SessionState {}

class SessionObject extends SessionState {
  final Session session;

  SessionObject({required this.session});
}

class SessionFailure extends SessionState {
  final String error;

  SessionFailure({required this.error});
}

class SeatsSuccessful extends SessionState {}

class BuySuccessful extends SessionState {}

class BuyError extends SessionState {
  final String error;

  BuyError({required this.error});
}
