import 'package:flutter/material.dart';
import 'package:fundus_app/constants/hive_boxes.dart';
import 'package:fundus_app/models/result.dart';

class ReportWidget extends StatelessWidget {
  final Result drResult;
  final Result glaucomaResult;
  const ReportWidget(this.drResult, this.glaucomaResult, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(drResult.date!);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Fundus Photo Screening Report",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Name: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("${currentUser.name}"),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Emirate ID: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("${currentUser.emirateId}"),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Date: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${date.day}-${date.month}-${date.year}",
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            height: MediaQuery.of(context).size.height / 5,
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Left Eye",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Right Eye",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.memory(
                            drResult.leftEyeImg!,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.memory(
                            drResult.rightEyeImg!,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TableCell(
                      child: Text(
                        "Normal Pathologies",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: TableCell(
                        child: Text(_getPathology()),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TableCell(
                      child: Text(
                        "Diabetic Retonapathy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: TableCell(
                        child: Text(_getDrIndicator(drResult.label)),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TableCell(
                      child: Text(
                        "Glaucoma",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: TableCell(
                        child: Text("${glaucomaResult.label}"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 35),
          const Text(
            "Referral Advice (Please refer to the following time for ophthalmology review)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Text(
              drResult.label == "Severe" || drResult.label == "Proliferate DR"
                  ? "YES"
                  : "NO",
            ),
          ),
          const SizedBox(height: 25),
          const Row(
            children: [
              Text(
                "Disclaimer: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  "This report does not replace professional medical advice, diagnosis or treatment.",
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
