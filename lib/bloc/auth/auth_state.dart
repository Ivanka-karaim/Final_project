import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState{}

class AuthSuccessful extends AuthState{}

class AuthFailure extends AuthState{}
