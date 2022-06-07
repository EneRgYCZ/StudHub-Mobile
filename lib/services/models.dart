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
<<<<<<< HEAD
  bool isVerified;
  String userName;
  String userPhoto;
  List<String> userContacts = <String>[];

  UserInfo({
    this.bio = '',
    this.isVerified = false,
    this.userName = '',
    this.userPhoto = '',
=======
  int isVerified;

  UserInfo({
    this.bio = '',
    this.isVerified = 0,
>>>>>>> 9606d0b42f8c2ede03c117006edd22eaba0b1661
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
