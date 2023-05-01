import 'package:flutter/material.dart';

import '../../models/seat.dart';

@immutable
abstract class SessionState {


}

class SessionInitial extends SessionState{}

class SessionBook extends SessionState{
}

class SessionFailure extends SessionState{}

