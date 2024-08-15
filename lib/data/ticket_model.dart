import 'package:json_annotation/json_annotation.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel {
  final String message;
  final Ticket ticket;
  final int scannedCount;

  TicketModel({
    required this.message,
    required this.ticket,
    required this.scannedCount,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => _$TicketModelFromJson(json);
  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}

@JsonSerializable()
class Ticket {
  @JsonKey(name: '_id')
  final String id;
  final String qrCodeData;
  final int ticketNumber;
  final bool isScanned;
  final DateTime expiresAt;
  final DateTime scannedAt;

  Ticket({
    required this.id,
    required this.qrCodeData,
    required this.ticketNumber,
    required this.isScanned,
    required this.expiresAt,
    required this.scannedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
