import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:final_project/repository/moveis_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

import '../../../models/ticket.dart';

// void func() async {
//   final pdf = Document();
//
//   pdf.addPage(Page(
//     build: (context) => Center(child: Text('Hello World!')),
//   ));
//
//   final Uint8List pdfData = await pdf.save();
//
//   final file = File('../../data/pdf/example.pdf');
//   await file.writeAsBytes(pdfData);
//
//   final Email email = Email(
//     body: 'Hello, please see attached PDF file',
//     subject: 'PDF file',
//     recipients: ['karaimivanna@gmail.com'],
//     attachmentPaths: ['../../data/pdf/example.pdf'],
//     isHTML: false,
//   );
//
//   await FlutterEmailSender.send(email);
//   print("good");
// }
Future<void> createPdf(Ticket ticket, final key) async {
  PdfDocument document = PdfDocument();
  document.pageSettings.size = PdfPageSize.a6;
  final page = document.pages.add();
  const pageSize = PdfPageSize.a6;

  // Додавання тексту з назвою кінотеатру
  final font = PdfStandardFont(PdfFontFamily.helvetica, 20);
  final brush2 = PdfSolidBrush(PdfColor(128, 0, 128));
  final text = 'CiNeMa';
  page.graphics.drawString(text, font, brush: brush2);

  // Завантажуємо зображення з URL
  final imageUrl = ticket.image;
  final imageResponse = await http.get(Uri.parse(imageUrl));
  final imageData = imageResponse.bodyBytes;

// Створюємо PdfBitmap з завантаженого зображення
//   final decodedImage = image.decodeImage(imageData);
  final pdfImage = PdfBitmap(imageData);

// Задаємо розміри для зображення
  const imageWidth = 100.0;
  const imageHeight = 150.0;

// Розміри області для інформації про фільм
  final infoWidth = page.getClientSize().width - imageWidth - 20.0;
  final infoHeight = 100.0;

// Розташування початку інформації про фільм
  final infoX = imageWidth + 20.0;
  final infoY = 50.0;

// Розташування початку зображення
  final imageX = 0.0;
  final imageY = infoY;

// Виводимо зображення на сторінку
  page.graphics.drawImage(
    pdfImage,
    Rect.fromLTWH(imageX, imageY, imageWidth, imageHeight),
  );

// Виводимо інформацію про фільм на сторінку
  page.graphics.drawString(
    ticket.name,
    PdfStandardFont(PdfFontFamily.helvetica, 16),
    bounds: Rect.fromLTWH(
        infoX as double, infoY as double, infoWidth, infoHeight as double),
  );
  page.graphics.drawString(
    'Room: ${ticket.roomName}',
    PdfStandardFont(PdfFontFamily.helvetica, 12),
    bounds: Rect.fromLTWH(
        infoX as double, infoY + 30, infoWidth, infoHeight as double),
  );
  page.graphics.drawString(
    'Row: ${ticket.rowIndex}',
    PdfStandardFont(PdfFontFamily.helvetica, 12),
    bounds: Rect.fromLTWH(
        infoX as double, infoY + 60, infoWidth, infoHeight as double),
  );
  page.graphics.drawString(
    'Place: ${ticket.seatIndex}',
    PdfStandardFont(PdfFontFamily.helvetica, 12),
    bounds: Rect.fromLTWH(
        infoX as double, infoY + 90, infoWidth, infoHeight as double),
  );

  final qrCode1 = QrImage(
    data: ticket.toString(), // перетворення об'єкта на рядок
    version: QrVersions.auto,
    gapless: false,
    size: 200,
  );
  final qrCode = QrImage(
    data: ticket.toString(),
    version: QrVersions.auto,
    gapless: false,
    size: 200,
  );

  final qrKey = GlobalKey();

  final widget = RepaintBoundary(
    key: qrKey,
    child: Column(children: [
      qrCode,
      TextButton(
        onPressed: () {
          getQr(qrKey);
        },
        child: Text(''),
      ),
    ]),
  );

  RenderRepaintBoundary boundary = key.currentContext.findRenderObject();

  final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  final ByteData? byteData =
  await image.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List? pngBytes = byteData?.buffer.asUint8List();
  final qrImage = PdfBitmap(pngBytes as List<int>);

  page.graphics
      .drawImage(qrImage, Rect.fromLTWH(imageX-20, imageY+150,qrImage.width+0.0, qrImage.height+0.0 ));

  List<int> bytes = await document.save();
  document.dispose();

  saveAndLaunchFile(bytes, 'Output.pdf');
}

Future<dynamic> getQr(final code) async {

}

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())?.path;
  print("good");
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  await OpenFile.open('$path/$fileName');
  print("good");
}
