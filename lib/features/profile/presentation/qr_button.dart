import 'package:final_project/features/profile/models/ticket.dart';
import 'package:final_project/features/session/presentation/pdf.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrAndButton extends StatelessWidget {
  final Ticket ticket;
  final GlobalKey _renderObjectKey = GlobalKey();

  QrAndButton({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RepaintBoundary(
          key: _renderObjectKey,
          child: QrImage(
            data: ticket.toString(),
            version: QrVersions.auto,
            gapless: false,
            size: 100,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8.0),
              backgroundColor: Colors.deepPurple),
          onPressed: () {
            createPdf(ticket, _renderObjectKey);
          },
          child: const Text('Переглянути'),
        ),
      ],
    );
  }
}
