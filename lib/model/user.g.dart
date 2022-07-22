// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      albumId: json['albumId'] as int?,
      userId: json['userId'] as int?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'albumId': instance.albumId,
      'userId': instance.userId,
      'name': instance.name,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
    };
