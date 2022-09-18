import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonSerializable()
class Post {
  int likes;
  String uid;
  List skills;
  String text;
  String title;
  String postId;
  List interests;
  String userName;
  String userPhoto;
  @TimestampConverter()
  DateTime date;

  Post({
    this.uid = '',
    this.likes = 0,
    this.text = '',
    this.title = '',
    this.postId = '',
    this.userName = '',
    required this.date,
    this.userPhoto = '',
    this.skills = const [],
    this.interests = const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class UserDetails {
  String uid;
  String bio;
  bool isVerified;
  String userName;
  String userPhoto;
  int notifications;
  List<String> skills = <String>[];
  List<String> history = <String>[];
  List<String> contacts = <String>[];
  List<String> interests = <String>[];
  List<String> likedPosts = <String>[];

  UserDetails({
    this.uid = '',
    this.bio = '',
    this.userName = '',
    this.userPhoto = '',
    this.notifications = 0,
    this.isVerified = false,
  });
  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}

@JsonSerializable()
class Blog {
  String title;
  List text;
  String photo;

  Blog({this.title = '', this.photo = '', this.text = const []});
  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);
  Map<String, dynamic> toJson() => _$BlogToJson(this);
}

@JsonSerializable()
class Message {
  String uid;
  String text;
  @TimestampConverter()
  final DateTime sentAt;

  Message({this.uid = '', this.text = '', required this.sentAt});
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class ChatRoom {
  String roomId;
  List participants;
  String text;
  @TimestampConverter()
  final DateTime sentAt;

  ChatRoom({
    this.participants = const [],
    this.roomId = '',
    this.text = '',
    required this.sentAt,
  });
  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}

@JsonSerializable()
class PostComment {
  String uid;
  String text;
  String userName;
  String userPhoto;
  @TimestampConverter()
  final DateTime postedAt;

  PostComment({
    this.uid = '',
    this.text = '',
    this.userName = '',
    this.userPhoto = '',
    required this.postedAt,
  });
  factory PostComment.fromJson(Map<String, dynamic> json) =>
      _$PostCommentFromJson(json);
  Map<String, dynamic> toJson() => _$PostCommentToJson(this);
}

@JsonSerializable()
class Tag {
  String title;
  int numberOfPosts;

  Tag({this.title = '', this.numberOfPosts = 0});
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}
