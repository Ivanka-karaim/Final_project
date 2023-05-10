import 'package:flutter/material.dart';

@immutable
abstract class HomeEvent{

}

class ChangeEvent extends HomeEvent{
  int? cIndex;

  ChangeEvent({required this.cIndex});

}