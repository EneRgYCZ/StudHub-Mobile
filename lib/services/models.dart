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
class UserExtraInfo {
  String bio;

  UserExtraInfo({this.bio = ''});
  factory UserExtraInfo.fromJson(Map<String, dynamic> json) =>
      _$UserExtraInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserExtraInfoToJson(this);
}
