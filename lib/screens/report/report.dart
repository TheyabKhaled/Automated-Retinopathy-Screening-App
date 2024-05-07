import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundus_app/constants/controllers.dart';
import 'package:fundus_app/constants/hive_boxes.dart';
import 'package:fundus_app/controllers/report_controller.dart';
import 'package:fundus_app/models/result.dart';
import 'package:fundus_app/widgets/print_report_widget.dart';
import 'package:fundus_app/widgets/report_widget.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportScreen extends StatelessWidget {
  final Result drResult;
  final Result glaucomaResult;
  final bool saved;
  const ReportScreen({
    super.key,
    required this.drResult,
    required this.glaucomaResult,
    this.saved = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Report"),
          actions: [
            IconButton(
              onPressed: () async {
                if (saved) return;
                try {
                  final pdf = pw.Document();

                  pdf.addPage(
                    pw.Page(
                      pageFormat: PdfPageFormat.a4,
                      build: (pw.Context context) {
                        return PrintReportWidget(drResult, glaucomaResult);
                      },
                    ),
                  );
                  Directory? directory = await getDownloadsDirectory();
                  Directory directory2 =
                      await getApplicationDocumentsDirectory();
                  final file = File(
                      "${directory?.path ?? directory2.path}/${DateTime.now()}.pdf");
                  await file.writeAsBytes(await pdf.save());

                  resultBox.add(
                    {
                      "drResult": drResult,
                      "glaucomaResult": glaucomaResult,
                    },
                  );

                  reportController.setIsPdfSaved(true);
                } catch (e) {
                  if (kDebugMode) {
                    reportController.setIsPdfSaved(false);
                    print(e.toString());
                  }
                }
              },
              icon: GetBuilder<ReportController>(
                builder: (controller) => Icon(
                  saved
                      ? Icons.check
                      : controller.isPdfSaved.value
                          ? Icons.check
                          : Icons.download,
                ),
              ),
            ),
          ],
        ),
        body: ReportWidget(drResult, glaucomaResult),
      ),
    );
  }
}
