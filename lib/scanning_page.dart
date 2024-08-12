import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'blocs/scan/scan_bloc.dart';
import 'blocs/scan/scan_event.dart';
import 'blocs/scan/scan_state.dart';


class ScanningPage extends StatefulWidget {
  const ScanningPage({super.key});

  @override
  State<ScanningPage> createState() => _ScanningPageState();
}

class _ScanningPageState extends State<ScanningPage> {
  late MobileScannerController mobileScannerController;

  @override
  void initState() {
    super.initState();
    mobileScannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      autoStart: true,
    );
  }

  @override
  void dispose() {
    mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanningBloc(mobileScannerController)..add(StartScanning()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Entry Tickets',
            style: TextStyle(color: Color(0xFF000000), fontSize: 28, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<ScanningBloc, ScanningState>(
          builder: (context, state) {
            var size = MediaQuery.of(context).size;
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: size.height,
                  width: size.width,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 48, 8, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 368,
                        width: size.width - 45,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: MobileScanner(
                                controller: mobileScannerController,
                                onDetect: (capture) {
                                  context.read<ScanningBloc>().add(BarcodeDetected(barcodes: capture.barcodes));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      if (state is ScanningLoading)
                        const CircularProgressIndicator()
                      else if (state is ScanningSuccess)
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Card(
                            color: const Color(0xFFFF6600),
                            child: Center(child: state.widget),
                          ),
                        )
                      else if (state is ScanningFailure)
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Card(
                              color: const Color(0xFFFF6600),
                              child: Center(child: Text(state.error)),
                            ),
                          )
                        else
                          const SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Card(
                              color: Color(0xFFFF6600),
                              child: Center(
                                child: Text(
                                  'Nothing Here',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                      SizedBox(
                        height: 51,
                        width: 148,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF111111),
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<ScanningBloc>().add(StopScanning());
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.pages_rounded),
                          label: const Text('Stop'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
