import 'package:flutter/material.dart';

abstract class ScanningState {}

class ScanningInitial extends ScanningState {}

class ScanningLoading extends ScanningState {}

class ScanningSuccess extends ScanningState {
  final Widget widget;
  ScanningSuccess({required this.widget});
}

class ScanningFailure extends ScanningState {
  final String error;
  ScanningFailure({required this.error});
}