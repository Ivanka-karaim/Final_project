import 'package:flutter/material.dart';

@immutable
abstract class HomeState {
  final int? cIndex;
  const HomeState(this.cIndex);

}

class HomeInitial extends HomeState{
  const HomeInitial() : super(0);

}

class HomeResultState extends HomeState{
  const HomeResultState(super.cIndex);
}