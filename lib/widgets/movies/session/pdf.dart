import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import '../../../models/ticket.dart';


Future<void> createPdf(Ticket ticket, final key) async {
  PdfDocument document = PdfDocument();
  document.pageSettings.size = PdfPageSize.a6;
  final page = document.pages.add();
  final font = PdfStandardFont(PdfFontFamily.helvetica, 20);
  final brush2 = PdfSolidBrush(PdfColor(128, 0, 128));
  const text = 'CiNeMa';
  page.graphics.drawString(text, font, brush: brush2);
  page.graphics.drawRectangle(bounds: const Rect.fromLTWH(0, 30, 400, 1), brush: brush2);

  final imageUrl = ticket.image;
  final imageResponse = await http.get(Uri.parse(imageUrl));
  final imageData = imageResponse.bodyBytes;

  final pdfImage = PdfBitmap(imageData);
  const imageWidth = 100.0;
  const imageHeight = 150.0;
  final infoWidth = page.getClientSize().width - imageWidth - 20.0;
  const infoHeight = 100.0;
  const infoX = imageWidth + 20.0;
  const infoY = 50.0;
  const imageX = 0.0;
  const imageY = infoY;


  page.graphics.drawImage(
    pdfImage,
    const Rect.fromLTWH(imageX, imageY, imageWidth, imageHeight),
  );

  page.graphics.drawString(
    ticket.name,
    PdfStandardFont(PdfFontFamily.helvetica, 16),
    bounds: Rect.fromLTWH(
        infoX, infoY, infoWidth, infoHeight),
  );
  page.graphics.drawString(
    'Room: ${ticket.roomName}',
    PdfStandardFont(PdfFontFamily.helvetica, 12),
    bounds: Rect.fromLTWH(
        infoX, infoY + 35, infoWidth, infoHeight),
  );
  page.graphics.drawString(
    'Row: ${ticket.rowIndex}',
    PdfStandardFont(PdfFontFamily.helvetica, 12),
    bounds: Rect.fromLTWH(
        infoX, infoY + 60, infoWidth, infoHeight),
  );
  page.graphics.drawString(
    'Place: ${ticket.seatIndex}',
    PdfStandardFont(PdfFontFamily.helvetica, 12),
    bounds: Rect.fromLTWH(
        infoX, infoY + 85, infoWidth, infoHeight),
  );
  page.graphics.drawString(
    'Date: ${ticket.date.hour}:${ticket.date.minute}  ${ticket.date.day.toString().padLeft(2, '0')}.${ticket.date.month.toString().padLeft(2, '0')}.${ticket.date.year}',
    PdfStandardFont(PdfFontFamily.helvetica, 12),
    bounds: Rect.fromLTWH(
        infoX, infoY + 110, infoWidth, infoHeight),
  );
  page.graphics.drawString(
    'Scan QR',
    PdfStandardFont(PdfFontFamily.helvetica, 12),
    bounds: Rect.fromLTWH(
        infoX-30, infoY + 160, infoWidth, infoHeight),
  );

  RenderRepaintBoundary boundary = key.currentContext.findRenderObject();

  final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  final ByteData? byteData =
  await image.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List? pngBytes = byteData?.buffer.asUint8List();
  final qrImage = PdfBitmap(pngBytes as List<int>);

  page.graphics
      .drawImage(qrImage, const Rect.fromLTWH(imageX+50, imageY+160,200, 150 ));

  List<int> bytes = await document.save();
  document.dispose();

  saveAndLaunchFile(bytes, 'Ticket-${ticket.id}.pdf');
}

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())?.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  await OpenFile.open('$path/$fileName');
}
