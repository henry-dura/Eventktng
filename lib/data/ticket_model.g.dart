// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      message: json['message'] as String,
      ticket: Ticket.fromJson(json['ticket'] as Map<String, dynamic>),
      scannedCount: (json['scannedCount'] as num).toInt(),
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'ticket': instance.ticket,
      'scannedCount': instance.scannedCount,
    };

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: json['_id'] as String,
      qrCodeData: json['qrCodeData'] as String,
      ticketNumber: (json['ticketNumber'] as num).toInt(),
      isScanned: json['isScanned'] as bool,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      scannedAt: DateTime.parse(json['scannedAt'] as String),
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      '_id': instance.id,
      'qrCodeData': instance.qrCodeData,
      'ticketNumber': instance.ticketNumber,
      'isScanned': instance.isScanned,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'scannedAt': instance.scannedAt.toIso8601String(),
    };
