import 'package:flutter/material.dart';
import 'package:fundus_app/constants/hive_boxes.dart';
import 'package:fundus_app/screens/report/report.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/result.dart';

class ReportHisotyPage extends StatelessWidget {
  const ReportHisotyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
      ),
      body: ValueListenableBuilder(
        valueListenable: resultBox.listenable(),
        builder: (context, box, child) {
          List<dynamic> results = box.values
              .toList()
              .where((result) =>
                  (result['drResult'] as Result).uid == currentUser.id)
              .toList();
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            padding: const EdgeInsets.all(10),
            itemCount: results.length,
            itemBuilder: (context, index) {
              Result drResult = results[index]['drResult'];
              Result glaucomaResult = results[index]['glaucomaResult'];
              DateTime date = DateTime.parse(drResult.date!);
              return ListTile(
                onTap: () {
                  Get.to(
                    () => ReportScreen(
                      drResult: drResult,
                      glaucomaResult: glaucomaResult,
                      saved: true,
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Colors.blueGrey[100],
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: double.maxFinite,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          drResult.leftEyeImg!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: double.maxFinite,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          drResult.rightEyeImg!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}",
                ),
                title: Text(drResult.label!),
              );
            },
          );
        },
      ),
    );
  }
}
