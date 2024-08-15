import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stadia_scanner/data/ticket_model.dart';
import '../secrets/secret.dart';


class ApiProvider {
  Future<TicketModel> verifyTicket(String barcode) async {
    final response = await http.post(
      Uri.parse('$secretBaseURL/tickets/verify'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'qrCodeData': barcode}),
    );

    if (response.statusCode == 200) {
      return TicketModel.fromJson(jsonDecode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception(
          // 'Failed to verify ticket. Status: ${response.statusCode}. Response: ${response.body}');
          'Failed to verify ticket.\n Reason: ${response.body}');
    }
  }
}
