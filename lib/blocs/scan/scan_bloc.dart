import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadia_scanner/blocs/scan/scan_event.dart';
import 'package:stadia_scanner/blocs/scan/scan_state.dart';
import '../../database/database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanningBloc extends Bloc<ScanningEvent, ScanningState> {
  final MobileScannerController mobileScannerController;

  ScanningBloc(this.mobileScannerController) : super(ScanningInitial()) {
    on<StartScanning>((event, emit) {
      mobileScannerController.start();
      emit(ScanningLoading());
    });

    on<BarcodeDetected>((event, emit) async {
      emit(ScanningLoading());
      try {
        for (final barcode in event.barcodes) {
          User user = await MongoDatabase.fetch(regId: barcode.rawValue!);
          if (barcode.rawValue == null) {
            emit(ScanningFailure(error: 'Incorrect Barcode'));
          } else if (user.regId == 'ResponseError') {
            emit(ScanningFailure(error: 'Incorrect Barcode'));
          } else if (user.isCheckedOut.toLowerCase() == 'true') {
            emit(ScanningFailure(error: 'Already checked in'));
          } else if (user.isCheckedIn.toLowerCase() == 'true') {
            emit(ScanningSuccess(
                widget: Text(
                    'Guest Already Checked In\nName: ${user.name}\nReg No.: ${user.regId}')));
          } else {
            emit(ScanningSuccess(
                widget: Text('Name: ${user.name}\nReg No.: ${user.regId}')));
          }
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
