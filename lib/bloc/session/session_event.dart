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

class GetSessionEvent extends SessionEvent{
  final int sessionId;
  GetSessionEvent({required this.sessionId});
}

class AddToListSeatsEvent extends SessionEvent{
  final Seat seat;
  AddToListSeatsEvent({required this.seat});
}

