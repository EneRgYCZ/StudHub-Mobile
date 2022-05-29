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
  String bio;
  int isVerified;

  UserInfo({
    this.bio = '',
    this.isVerified = 0,
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
