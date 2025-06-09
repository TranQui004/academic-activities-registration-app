import 'package:doan/main.dart';
import 'package:doan/models/event.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class QRCodePage extends StatelessWidget {
  Event? event;

  QRCodePage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Mã QR điểm danh',),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QR cho sự kiện:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              event!.TenSuKien!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              event!.DDToChuc!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              event!.TGToChuc!.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: event!.id!,
              width: 200,
              height: 200,
              errorBuilder: (context, error) => Text('Lỗi tạo QR'),
            ),
          ],
        ),
      ),
      drawer: DrawerBaseKhoa(),
    );
  }
}
