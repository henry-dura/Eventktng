
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'commons.dart';
import 'database/database.dart';

class EntryAndExitPage extends StatefulWidget {

  const EntryAndExitPage({
    super.key,

  });

  @override
  State<EntryAndExitPage> createState() => _EntryAndExitPageState();
}

class _EntryAndExitPageState extends State<EntryAndExitPage> {
  bool isScanning = true;
  late MobileScannerController mobileScannerController;


  // var mobileScannerController = MobileScannerController(
  //   detectionSpeed: DetectionSpeed.noDuplicates,
  //   autoStart: true,
  // );

  var gradient = const LinearGradient(
    colors: [Colors.black, Colors.black54],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  var widget1 = const Text(
    'Nothing Here',
    style: TextStyle(color: Colors.white),
  );


  @override
  void initState() {
    super.initState();
    // Initialize the MobileScannerController
    mobileScannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      autoStart: true,
    );
  }

  @override
  void dispose() {
    // Dispose the MobileScannerController to free resources
    mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: const Text(
           'Entry Tickets',
          style: TextStyle(color: Color(0xFF000000),fontSize: 28,fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        // backgroundColor: widget.isInEntryMode
        //     ? Colors.green.withOpacity(0.8)
        //     : Colors.redAccent.withOpacity(0.8),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: size.height,
            width: size.height,

            // child: RotatedBox(
            //   quarterTurns:  1 ,
            //   child: ImageFiltered(
            //
            //     imageFilter:
            //         ColorFilter.mode(Colors.pinkAccent.shade700, BlendMode.color),
            //     child: LottieBuilder.asset(
            //       'assets/bg.json',
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 48, 8, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: size.width - 16,
                  width: size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: LottieBuilder.asset(
                      //     widget.isInEntryMode
                      //         ? 'assets/entryExit.json'
                      //         : 'assets/entryExit2.json',
                      //   ),
                      // ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: MobileScanner(
                          controller: mobileScannerController,
                          onDetect: (capture) async {
                             List<Barcode> barcodes = capture.barcodes;
                            print('FIrst: $barcodes');
                            for (final barcode in barcodes) {
                              print('A code XXXXXXXXXXXX : ${barcode.rawValue}');
                              User user = await MongoDatabase.fetch(
                                  regId: barcode.rawValue!);
                              setState(() {
                                mobileScannerController.stop();
                                isScanning = false;

                                if (barcode.rawValue == null) {
                                  widget1 = myText('Null Error. Try Again !');
                                  gradient = blackGradient;
                                } else if (user.regId == 'ResponseError') {
                                  widget1 = myText('Invalid Ticket');
                                  gradient = redGradient;
                                } else if (user.isCheckedOut.toLowerCase() ==
                                    'true') {
                                  widget1 = myText(
                                      'Guest Already Checked Out\nName: ${user.name}\nReg No.: ${user.regId}');
                                  gradient = yellowGradient;
                                } else if (user.isCheckedIn.toLowerCase() ==
                                        'true') {
                                  widget1 = myText(
                                      'Guest Already Checked In\nName: ${user.name}\nReg No.: ${user.regId}');
                                  gradient = yellowGradient;
                                } else if (user.isCheckedIn.toLowerCase() ==
                                        'true') {
                                  widget1 = myText(
                                      'Name: ${user.name}\nReg No.: ${user.regId}');
                                  gradient = greenGradient;
                                  // MongoDatabase.update(
                                  //     regId: barcode.rawValue!,
                                  //     isInEntryMode: widget.isInEntryMode);
                                } else {
                                  widget1 = myText(
                                      'Name: ${user.name}\nReg No.: ${user.regId}');
                                  gradient = greenGradient;
                                  // MongoDatabase.update(
                                  //     regId: barcode.rawValue!,
                                  //     isInEntryMode: widget.isInEntryMode);
                                }
                              });
                              barcodes = [];
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                AnimatedContainer(
                  width: size.width,
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                      // color: Colors.purple,
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.all(16),
                  child: Center(child: widget1),
                ),
                ElevatedButton.icon(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isScanning = false;
                            mobileScannerController.stop();
                            widget1 = const Text(
                              'Nothing Here',
                              style: TextStyle(color: Colors.white),
                            );
                            Navigator.pop(context);
                            // gradient = blackGradient;
                          });
                        },
                        icon: const Icon(Icons.pages_rounded),
                        label: const Text('Stop'),
                      )
                     // Hero(
                     //    tag: 'entry',
                     //    child: ElevatedButton.icon(
                     //      style: ButtonStyle(
                     //        shape: MaterialStatePropertyAll(
                     //          RoundedRectangleBorder(
                     //            side: const BorderSide(color: Colors.white),
                     //            borderRadius: BorderRadius.circular(16),
                     //          ),
                     //        ),
                     //      ),
                     //      onPressed: () {
                     //        mobileScannerController.start();
                     //        setState(() {
                     //          isScanning = true;
                     //          widget1 = const Text(
                     //            'Nothing Here',
                     //            style: TextStyle(color: Colors.white),
                     //          );
                     //          gradient = blackGradient;
                     //        });
                     //      },
                     //      icon: const Icon(Icons.document_scanner_outlined),
                     //      label: const Text('Scan'),
                     //    ),
                     //  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
