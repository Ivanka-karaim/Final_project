import 'package:final_project/models/session.dart';
import 'package:flutter/material.dart';

import '../../models/seat.dart';

@immutable
abstract class SessionEvent {}

class BookSeatsEvent extends SessionEvent{
  final Session session;
  final List<Seat> seats;

  BookSeatsEvent( {required this.session,required this.seats});
}

