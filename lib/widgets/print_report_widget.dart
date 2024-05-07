import 'package:fundus_app/constants/hive_boxes.dart';
import 'package:fundus_app/models/result.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintReportWidget extends pw.StatelessWidget {
  final Result drResult;
  final Result glaucomaResult;
  PrintReportWidget(
    this.drResult,
    this.glaucomaResult,
  );

  @override
  pw.Widget build(pw.Context context) {
    DateTime date = DateTime.parse(drResult.date!);
    return pw.Padding(
      padding: const pw.EdgeInsets.all(20),
      child: pw.Column(
        children: [
          pw.Text(
            "Fundus Photo Screening Report",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 18,
            ),
          ),
          pw.SizedBox(height: 15),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Text(
                        "Name: ",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text("${currentUser.name}"),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        "Emirate ID: ",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text("${currentUser.emirateId}"),
                    ],
                  ),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(
                    "Date: ",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "${date.day}-${date.month}-${date.year}",
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 15),
          pw.Container(
            height: 180,
            width: double.maxFinite,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Column(
              children: [
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    pw.Text(
                      "Left Eye",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      "Right Eye",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.Expanded(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Image(
                            pw.MemoryImage(drResult.leftEyeImg!),
                            fit: pw.BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Image(
                            pw.MemoryImage(drResult.rightEyeImg!),
                            fit: pw.BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 15),
          pw.SizedBox(
            width: double.maxFinite,
            child: pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                    ),
                    child: pw.Text(
                      "Normal Pathologies",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                    ),
                    child: pw.Center(
                      child: pw.Text(_getPathology()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(
            width: double.maxFinite,
            child: pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                    ),
                    child: pw.Text(
                      "Diabetic Retonapathy",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                    ),
                    child: pw.Center(
                      child: pw.Text(_getDrIndicator(drResult.label)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(
            width: double.maxFinite,
            child: pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                    ),
                    child: pw.Text(
                      "Glaucoma",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                    ),
                    child: pw.Center(
                      child: pw.Text("${glaucomaResult.label}"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 35),
          pw.Text(
            "Referral Advice (Please refer to the following time for ophthalmology review)",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 20),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Text(
              drResult.label == "Severe" || drResult.label == "Proliferate DR"
                  ? "YES"
                  : "NO",
            ),
          ),
          pw.SizedBox(height: 25),
          pw.Row(
            children: [
              pw.Text(
                "Disclaimer: ",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Row(
            children: [
              pw.SizedBox(width: 20),
              pw.Expanded(
                child: pw.Text(
                  "This report does not replace professional medical advice, diagnosis or treatment.",
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getPathology() {
    String pathology = "";
    switch (drResult.label) {
      case "Moderate":
      case "Proliferate DR":
      case "Severe":
        pathology += "DR Positive";
        break;
    }
    switch (glaucomaResult.label) {
      case "Positive":
        pathology += ", Glaucoma Positive";
        break;
    }
    return pathology;
  }

  String _getDrIndicator(String? label) {
    switch (label) {
      case "MIld":
        return "Mild Non-Proliferate DR";
      case "Moderate":
        return "Moderate Non-Proliferate DR";
      case "No DR":
        return "No DR Found";
      case "Proliferate DR":
        return "Severe Proliferate DR";
      case "Severe":
        return "Severe Non-Proliferate DR";
      default:
        return "Mild Non-Proliferate DR";
    }
  }
}
