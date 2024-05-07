import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fundus_app/constants/hive_boxes.dart';
import 'package:fundus_app/screens/history/history.dart';
import 'package:fundus_app/screens/login/login.dart';
import 'package:get/get.dart';

class DrawerContents extends StatelessWidget {
  const DrawerContents({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 15),
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              children: currentUser.toJson().entries.map(
                (data) {
                  if (data.key.toLowerCase() == 'id') return const SizedBox();
                  return ListTile(
                    title: Text("${data.key.toUpperCase()}: ${data.value}"),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          onTap: () async {
            Get.back();
            Get.to(() => const ReportHisotyPage());
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          tileColor: Colors.blueGrey[100],
          leading: const Icon(Icons.history),
          title: const Text("Report History"),
        ),
        const SizedBox(height: 10),
        ListTile(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            userBox.clear();
            Get.offAll(() => const LoginPage());
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          tileColor: Colors.blueGrey[100],
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
        ),
      ],
    );
  }
}
