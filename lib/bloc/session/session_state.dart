import 'package:final_project/models/session.dart';
import 'package:flutter/material.dart';

import '../../models/seat.dart';

@immutable
abstract class SessionState {


}

class SessionInitial extends SessionState{}

class SessionBook extends SessionState{
}

class SessionObject extends SessionState{
  final Session session;

  SessionObject({required this.session});
}

class SessionFailure extends SessionState{
  final String error;
  SessionFailure({required this.error});
}

class SeatsSuccessful extends SessionState{}

class BuySuccessful extends SessionState{}

