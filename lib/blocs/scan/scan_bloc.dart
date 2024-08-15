import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadia_scanner/blocs/scan/scan_event.dart';
import 'package:stadia_scanner/blocs/scan/scan_state.dart';
import 'package:stadia_scanner/data/repository.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanningBloc extends Bloc<ScanningEvent, ScanningState> {
  final MobileScannerController mobileScannerController;
  final Repository repository;

  ScanningBloc(this.mobileScannerController, this.repository) : super(ScanningInitial()) {
    on<StartScanning>((event, emit) {
      mobileScannerController.start();
      // emit(ScanningLoading());
    });

    on<BarcodeDetected>((event, emit) async {
      mobileScannerController.stop();
      emit(ScanningLoading());
      try {
        for (final barcode in event.barcodes) {
          // if (barcode.rawValue == null) {
          //   emit(ScanningFailure(error: 'Incorrect Barcode'));
          //   continue;
          // }
          print('bwhjjwjejrngngvggggggggggggggggggggggggggggg ${barcode.rawValue}');


          // Perform the verification using the repository
          // final data = await repository.verifyTicket(barcode.rawValue!);
          final ticketModel = await repository.verifyTicket("NPL-17");
          // print('This is available returne data wqrtwrwtwtyywywhw : $data');

          emit(ScanningSuccess(ticketModel: ticketModel));


        }
      } catch (e) {
        emit(ScanningFailure(error: e.toString()));
      }
    });

    on<StopScanning>((event, emit) {
      mobileScannerController.stop();
      emit(ScanningInitial());
    });
  }
}