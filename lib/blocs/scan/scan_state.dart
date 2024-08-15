import 'package:equatable/equatable.dart';

import '../../data/ticket_model.dart';

abstract class ScanningState extends Equatable{
  const ScanningState();

  @override
  List<Object> get props => [];
}

class ScanningInitial extends ScanningState {}

class ScanningLoading extends ScanningState {}

class ScanningSuccess extends ScanningState {
  final TicketModel ticketModel;

  const ScanningSuccess({required this.ticketModel});

  @override
  List<Object> get props => [ticketModel];
}

class ScanningFailure extends ScanningState {
  final String error;
  const ScanningFailure({required this.error});

  @override
  List<Object> get props => [error];
}