import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:pdf/widgets.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

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
Future<void> createPdf() async {
  PdfDocument document = PdfDocument();
  final page = document.pages.add();
  
  page.graphics.drawString('Welcome', PdfStandardFont(PdfFontFamily.helvetica, 30));

  List<int> bytes = await document.save() ;
  document.dispose();

  saveAndLaunchFile(bytes, 'Output.pdf');
}

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async{
  final path = (await getExternalStorageDirectory())?.path;
  print("good");
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush:true);
  await OpenFile.open('$path/$fileName');
  print("good");

  final Email email = Email(
    body: 'Hello, please see attached PDF file',
    subject: 'PDF file',
    recipients: ['karaimivanna@gmail.com'],
    attachmentPaths: ['$path/$fileName'],
    isHTML: false,
  );

  await FlutterEmailSender.send(email);
  print("good");
}
