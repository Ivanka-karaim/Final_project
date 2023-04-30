import 'package:flutter/material.dart';

import '../../models/ticket.dart';
import '../../models/user.dart';

@immutable
abstract class ProfileState {


}

class ProfileInitial extends ProfileState{}

class ProfileInformation extends ProfileState{
  final User? user;

  ProfileInformation({required this.user});
}

class ProfileFailure extends ProfileState{}

class ProfileInformationTickets extends ProfileState {
  final List<Ticket> tickets;

  ProfileInformationTickets({required this.tickets});

}