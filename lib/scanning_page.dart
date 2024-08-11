
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'database/database.dart';

class ScanningPage extends StatefulWidget {

  const ScanningPage({
    super.key,

  });

  @override
  State<ScanningPage> createState() => _ScanningPageState();
}

class _ScanningPageState extends State<ScanningPage> {

  late MobileScannerController mobileScannerController;


  Widget widget1 = const Text(
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
      ),
      body: Stack(
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
                  width: size.width- 45,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [

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

                                if (barcode.rawValue == null) {
                                  widget1 = Row(children: [Icon(Icons.cancel_outlined), Text('Incorrect Barcode')],);
                                  // gradient = blackGradient;
                                } else if (user.regId == 'ResponseError') {
                                  widget1 = Row(children: [Icon(Icons.cancel_outlined), Text('Incorrect Barcode')],);
                                  // gradient = redGradient;
                                } else if (user.isCheckedOut.toLowerCase() ==
                                    'true') {
                                  widget1 = Row(children: [Icon(Icons.cancel_outlined), Text('Already checked in')],);
                                  // gradient = yellowGradient;
                                } else if (user.isCheckedIn.toLowerCase() ==
                                        'true') {
                                  widget1 = Text(
                                      'Guest Already Checked In\nName: ${user.name}\nReg No.: ${user.regId}');
                                  // gradient = yellowGradient;
                                } else if (user.isCheckedIn.toLowerCase() ==
                                        'true') {
                                  widget1 = Text(
                                      'Name: ${user.name}\nReg No.: ${user.regId}');
                                  // gradient = greenGradient;
                                  // MongoDatabase.update(
                                  //     regId: barcode.rawValue!,
                                  //     isInEntryMode: widget.isInEntryMode);
                                } else {
                                  widget1 = Text(
                                      'Name: ${user.name}\nReg No.: ${user.regId}');
                                  // gradient = greenGradient;
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
                // AnimatedContainer(
                //   width: size.width,
                //   duration: const Duration(milliseconds: 250),
                //   decoration: BoxDecoration(
                //       // color: Colors.purple,
                //       // gradient: gradient,
                //       borderRadius: BorderRadius.circular(16)),
                //   padding: const EdgeInsets.all(16),
                //   child: Center(child: widget1),
                // ),

                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Card(color: Color(0xFFFF6600),child: Center(child: widget1),)),

                SizedBox(
                  height: 51,
                  width: 148,
                  child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF111111)),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              mobileScannerController.stop();

                              Navigator.pop(context);
                              // gradient = blackGradient;
                            });
                          },
                          icon: const Icon(Icons.pages_rounded),
                          label: const Text('Stop'),
                        ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
