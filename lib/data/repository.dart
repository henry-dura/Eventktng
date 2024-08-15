import 'package:stadia_scanner/data/ticket_model.dart';

import 'api_provider.dart';

class Repository {
  final ApiProvider apiProvider = ApiProvider();
  Future<TicketModel> verifyTicket(String barcode) async {
     return await apiProvider.verifyTicket(barcode);

  }
}
