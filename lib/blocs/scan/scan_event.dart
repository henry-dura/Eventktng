// scanning_event.dart
import 'package:mobile_scanner/mobile_scanner.dart';

abstract class ScanningEvent {}

class StartScanning extends ScanningEvent {}

class BarcodeDetected extends ScanningEvent {
  final List<Barcode> barcodes;
  BarcodeDetected({required this.barcodes});
}

class StopScanning extends ScanningEvent {}
