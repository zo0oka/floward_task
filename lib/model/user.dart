import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: 'albumId')
  int? albumId;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'thumbnailUrl')
  String? thumbnailUrl;

  User({this.albumId, this.userId, this.name, this.url, this.thumbnailUrl});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
