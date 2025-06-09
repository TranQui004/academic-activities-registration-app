import 'dart:typed_data';
import 'package:doan/main.dart';
import 'package:doan/models/event.dart';
import 'package:doan/models/sinhvien.dart';
import 'package:doan/services/cloud_service.dart';
import 'package:doan/services/dangky_services.dart';
import 'package:doan/views/thongtindiendanh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  CameraController? _cameraController;
  BarcodeScanner? _barcodeScanner;
  bool _isBusy = false;
  bool _isCameraInitialized = false;
  String? result;

  @override
  void initState() {
    super.initState();
    _barcodeScanner = BarcodeScanner(
      //formats: [BarcodeFormat.qrCode],
    );
    _initCamera();
  }

  Future<void> xuLyDiemDanh() async{
    final sv = Provider.of<SinhVienProvider>(context, listen: false).sinhVien!;
    if(result != null && sv! != null){
      Event? e = Event.fromMap(await CloudService().getEventById(result!) as Map<String, dynamic>);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ThongTinSVSauQuet(sv: sv, sk: e!),));
    }
  }

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bạn cần cấp quyền camera để sử dụng tính năng này.')),
      );
      return;
    }

    final cameras = await availableCameras();

    final camera = cameras.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    print('😍😍😍${camera.sensorOrientation}');

    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await _cameraController!.initialize();
      await _cameraController!.startImageStream(_processCameraImage);
      setState(() {_isCameraInitialized = true;});
    } catch (e) {
      print('❌ Lỗi khi khởi tạo camera: $e');
    }
  }

  Uint8List flipPlaneHorizontal(Uint8List bytes, int width, int height) {
    final flipped = Uint8List(bytes.length);
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final srcIndex = y * width + x;
        final dstIndex = y * width + (width - 1 - x);
        flipped[dstIndex] = bytes[srcIndex];
      }
    }
    return flipped;
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isBusy) return;
    _isBusy = true;

    try {
      final width = image.width;
      final height = image.height;

      // Lật từng plane ảnh theo kích thước của từng plane
      // Plane 0: Y (full size)
      final flippedPlane0 = flipPlaneHorizontal(image.planes[0].bytes, width, height);

      // Plane 1 và 2: U và V (thường là 1/2 kích thước)
      final plane1Width = (width / 2).floor();
      final plane1Height = (height / 2).floor();
      final flippedPlane1 = flipPlaneHorizontal(image.planes[1].bytes, plane1Width, plane1Height);

      final plane2Width = (width / 2).floor();
      final plane2Height = (height / 2).floor();
      final flippedPlane2 = flipPlaneHorizontal(image.planes[2].bytes, plane2Width, plane2Height);

      // Gom bytes lại theo thứ tự Y, U, V
      final WriteBuffer allBytes = WriteBuffer();
      allBytes.putUint8List(flippedPlane0);
      allBytes.putUint8List(flippedPlane1);
      allBytes.putUint8List(flippedPlane2);
      final flippedBytes = allBytes.done().buffer.asUint8List();

      final Size imageSize = Size(width.toDouble(), height.toDouble());
      final camera = _cameraController!.description;

      final imageRotation = InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
          InputImageRotation.rotation0deg;

      // Cố định định dạng ảnh NV21 cho Android
      final inputImageFormat = InputImageFormat.nv21;

      final inputImage = InputImage.fromBytes(
        bytes: flippedBytes,
        metadata: InputImageMetadata(
          size: imageSize,
          rotation: imageRotation,
          format: inputImageFormat,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final barcodes = await _barcodeScanner!.processImage(inputImage);

      for (final barcode in barcodes) {
        if (barcode.format == BarcodeFormat.qrCode) {
          final qrValue = barcode.rawValue ?? '';
          setState(() {
            result = qrValue;
          });
          xuLyDiemDanh();
          print('✅ Mã QR: $qrValue');
          break; // Lấy mã đầu tiên
        }
      }
    } catch (e) {
      print('❌ Lỗi khi đọc mã QR: $e');
    } finally {
      _isBusy = false;
    }
  }


  @override
  void dispose() {
    _cameraController?.dispose();
    _barcodeScanner?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Quét mã điểm danh'),
      body: Column(
        children: [
          if (_isCameraInitialized && _cameraController != null)
            AspectRatio(
              aspectRatio: 0.6,
              child: CameraPreview(_cameraController!),
            )
          else
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            ),
          const SizedBox(height: 10),
          Text(
            result != null
                ? 'Mã quét được: $result'
                : 'Chưa phát hiện mã nào',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
