// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      uid: json['uid'] as String? ?? '',
      date: json['date'] as String? ?? '',
      text: json['text'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      userPhoto: json['userPhoto'] as String? ?? '',
      skills: json['skills'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'uid': instance.uid,
      'date': instance.date,
      'skills': instance.skills,
      'text': instance.text,
      'userName': instance.userName,
      'userPhoto': instance.userPhoto,
    };

UserExtraInfo _$UserExtraInfoFromJson(Map<String, dynamic> json) =>
    UserExtraInfo(
      bio: json['bio'] as String? ?? '',
    );

Map<String, dynamic> _$UserExtraInfoToJson(UserExtraInfo instance) =>
    <String, dynamic>{
      'bio': instance.bio,
    };