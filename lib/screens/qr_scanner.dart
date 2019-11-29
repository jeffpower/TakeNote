// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRScanner extends StatefulWidget {
//   @override
//   _QRScannerState createState() => _QRScannerState();
// }

// class _QRScannerState extends State<QRScanner> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   var qrText = "";
//   QRViewController controller;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: QRView(
//               key: qrKey,
//               // onQRViewCreated: 
//               // _onQRViewCreated,
//             ),
//             flex: 4,
//           ),

//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 Text("This is the result of the scan: $qrText"),
//                 RaisedButton(
//                   onPressed: () {
//                     if(controller != null) {
//                       controller.flipCamera();
//                     }
//                   },

//                   child: Text(
//                     'Flip',
//                     style: TextStyle(fontSize: 20)
//                   ),
//                 )
//               ],
              
//             ),
//             flex: 1,
//           )
//         ],
//       ),
//     );
//   }

  
  
// }