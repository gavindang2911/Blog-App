// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    json['DOB'] as String,
    json['about'] as String,
    json['name'] as String,
    json['profession'] as String,
    json['titleline'] as String,
    json['username'] as String,
  );
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'profession': instance.profession,
      'DOB': instance.DOB,
      'titleline': instance.titleline,
      'about': instance.about,
    };
