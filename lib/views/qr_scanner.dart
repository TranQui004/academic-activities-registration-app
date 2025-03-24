// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'dart:io';
// import 'package:doan/main.dart'; 
// class QRScanner extends StatefulWidget {
//   const QRScanner({super.key});

//   @override
//   State<QRScanner> createState() => _QRScannerState();
// }

// class _QRScannerState extends State<QRScanner> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String scannedResult = '';
//   bool isScanning = false;

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller?.pauseCamera();
//     }
//     controller?.resumeCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const AppBarBase(titleText: 'Quét mã QR'), // Sử dụng AppBarBase
//       drawer: const DrawerBase(), // Thêm DrawerBase
//       body: SingleChildScrollView( // Thêm SingleChildScrollView để tránh overflow
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: () {
//                   setState(() {
//                     isScanning = !isScanning;
//                   });
//                   if (!isScanning) {
//                     controller?.pauseCamera();
//                   } else {
//                     controller?.resumeCamera();
//                   }
//                 },
//                 icon: Icon(
//                   isScanning ? FontAwesomeIcons.stop : FontAwesomeIcons.qrcode,
//                   color: AppColors.textWhite,
//                 ),
//                 label: Text(
//                   isScanning ? 'Dừng quét' : 'Bắt đầu quét',
//                   style: const TextStyle(color: AppColors.textWhite),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary, // Sử dụng màu primary từ AppColors
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               if (isScanning)
//                 Container(
//                   height: 300,
//                   width: 300,
//                   child: QRView(
//                     key: qrKey,
//                     onQRViewCreated: _onQRViewCreated,
//                     overlay: QrScannerOverlayShape(
//                       borderColor: AppColors.primary, // Sử dụng màu primary từ AppColors
//                       borderRadius: 10,
//                       borderLength: 30,
//                       borderWidth: 10,
//                       cutOutSize: 250,
//                     ),
//                   ),
//                 ),
//               const SizedBox(height: 20),
//               if (scannedResult.isNotEmpty)
//                 Text(
//                   'Kết quả quét: $scannedResult',
//                   style: TextStyle(fontSize: 16, color: AppColors.textBlack), // Sử dụng textBlack từ AppColors
//                   textAlign: TextAlign.center,
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         scannedResult = scanData.code ?? 'Không có dữ liệu';
//         isScanning = false;
//       });
//       controller.pauseCamera();
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }