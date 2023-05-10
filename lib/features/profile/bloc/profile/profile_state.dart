import 'package:final_project/features/profile/models/ticket.dart';
import 'package:final_project/features/profile/models/user.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileInformation extends ProfileState {
  final User? user;

  ProfileInformation({required this.user});
}

class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure({required this.error});
}

class ProfileInformationTickets extends ProfileState {
  final List<Ticket> tickets;

  ProfileInformationTickets({required this.tickets});
}

class ChangeUserSuccessful extends ProfileState {
  final User user;

  ChangeUserSuccessful({required this.user});
}
