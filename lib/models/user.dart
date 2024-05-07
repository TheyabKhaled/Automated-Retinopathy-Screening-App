import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? emirateId;

  User({this.id, this.name, this.email, this.emirateId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emirateId = json['emirateId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['emirateId'] = emirateId;
    return data;
  }
}
