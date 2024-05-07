import 'package:fundus_app/models/user.dart';
import 'package:hive/hive.dart';

const String userBoxName = 'userBox';
const String resultBoxName = 'resultBox';

late Box userBox;
late Box resultBox;

final User currentUser = userBox.getAt(0);
