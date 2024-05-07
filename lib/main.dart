import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fundus_app/controllers/camera_controller.dart';
import 'package:fundus_app/controllers/login_controller.dart';
import 'package:fundus_app/controllers/report_controller.dart';
import 'package:fundus_app/controllers/signup_controller.dart';
import 'package:fundus_app/firebase_options.dart';
import 'package:fundus_app/models/result.dart';
import 'package:fundus_app/models/user.dart' as model;
import 'package:fundus_app/screens/dashboard/dashboard.dart';
import 'package:fundus_app/screens/login/login.dart';
import 'package:fundus_app/screens/verification/user_verification.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'constants/hive_boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  putControllers();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(model.UserAdapter());
  Hive.registerAdapter(ResultAdapter());
  userBox = await Hive.openBox(userBoxName);
  resultBox = await Hive.openBox(resultBoxName);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

void putControllers() {
  Get.lazyPut(() => LoginController(), fenix: true);
  Get.lazyPut(() => SignupController(), fenix: true);
  Get.lazyPut(() => CameraStateController(), fenix: true);
  Get.lazyPut(() => ReportController(), fenix: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fundus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
              return const DashboardPage();
            } else {
              return const VerificationScreen();
            }
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
