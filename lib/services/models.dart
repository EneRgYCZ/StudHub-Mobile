import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class Post {
  String uid;
  String date;
  List skills;
  String text;
  String userName;
  String userPhoto;

  Post({
    this.uid = '',
    this.date = '',
    this.text = '',
    this.userName = '',
    this.userPhoto = '',
    this.skills = const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class UserInfo {
  String uid;
  String bio;
  bool isVerified;
  String userName;
  String userPhoto;
  List<String> userContacts = <String>[];

  UserInfo({
    this.uid = '',
    this.bio = '',
    this.userName = '',
    this.userPhoto = '',
    this.isVerified = false,
  });
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class Blog {
  String title;
  String text;
  String photo;

  Blog({this.title = '', this.photo = '', this.text = ''});
  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);
  Map<String, dynamic> toJson() => _$BlogToJson(this);
}

@JsonSerializable()
class Message {
  String uid;
  String message;
  String userName;
  String userPhoto;
  DateTime createdAt =
      DateFormat.yMMMMd('en_US').format(DateTime.now()) as DateTime;

  Message({
    this.uid = '',
    this.message = '',
    this.userName = '',
    this.userPhoto = '',
  });
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
