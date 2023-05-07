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

class BuySeatsEvent extends SessionEvent{
  final int sessionId;
  final List<Seat> seats;
  final String cardNumber;
  final String expirationDate;
  final String cvv;
  final String email;

  BuySeatsEvent({required this.sessionId,required this.seats, required this.cardNumber, required this.expirationDate, required this.cvv, required this.email});

}
class AddToListSeatsEvent extends SessionEvent{
  final Seat seat;
  AddToListSeatsEvent({required this.seat});
}

