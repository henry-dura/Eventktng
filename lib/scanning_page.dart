import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/scan/scan_bloc.dart';
import 'blocs/scan/scan_event.dart';
import 'blocs/scan/scan_state.dart';
import 'data/repository.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // Ensure you have this package imported


// Define your Repository, ScanningBloc, ScanningState, and other necessary classes here

class ScanningPage extends StatefulWidget {
  const ScanningPage({super.key});

  @override
  State<ScanningPage> createState() => _ScanningPageState();
}

class _ScanningPageState extends State<ScanningPage> {
  late MobileScannerController mobileScannerController;
  late Repository repository;
  late ScanningBloc scanningBloc;

  @override
  void initState() {
    super.initState();
    mobileScannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      autoStart: true,
    );

    repository = Repository();
    scanningBloc = ScanningBloc(mobileScannerController, repository)..add(StartScanning());
  }

  @override
  void dispose() {
    mobileScannerController.dispose();
    scanningBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => scanningBloc,
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
        body: BlocConsumer<ScanningBloc, ScanningState>(
          listener: (context, state) {
            if (state is ScanningFailure) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Center(
                    child: Icon(
                      Icons.error_outlined,
                      size: 100,
                      color: Colors.red,
                    ),
                  ),
                  content: Text(
                    state.error,
                    style: const TextStyle(fontSize: 18),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Center(
                        child: Text(
                          "OK",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ScanningSuccess) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 100,
                      color: Colors.green,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Ticket No: ${state.ticketModel.ticket}', style: const TextStyle(fontSize: 18)),
                      Text(state.ticketModel.message, style: const TextStyle(fontSize: 18)),
                      Text('Total Scanned: ${state.ticketModel.scannedCount}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Center(
                        child: Text(
                          "OK",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
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
                            if (state is ScanningLoading)
                              const CircularProgressIndicator()
                            else if (state is ScanningSuccess || state is ScanningFailure)
                              const SizedBox()
                            else
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: MobileScanner(
                                  controller: mobileScannerController,
                                  onDetect: (capture) {
                                    context.read<ScanningBloc>().add(BarcodeDetected(barcodes: capture.barcodes));
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (!(state is ScanningLoading || state is ScanningSuccess || state is ScanningFailure))
                        const SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Card(
                            color: Color(0xFFFF6600),
                            child: Center(
                              child: Text(
                                'Nothing Captured yet',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      if (!(state is ScanningLoading || state is ScanningSuccess || state is ScanningFailure))
                      SizedBox(
                        height: 51,
                        width: 148,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF111111)),
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
